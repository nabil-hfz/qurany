import { AppDataSource } from './../db/index';

import { Repository as TypeORMRepository, EntityTarget, ObjectLiteral, FindOneOptions, ObjectId, FindManyOptions } from 'typeorm';
import { logError } from '../utils/logger';
import { AppPagination } from '../middlewares/pagination.middleware';

export interface GetAllOptions<T> {
  conditions?: Partial<T> & Partial<AppPagination>,
  order?: { [P in keyof T]?: 'ASC' | 'DESC' },
  relations?: { [P in keyof T]?: boolean },
}


export abstract class Repository<T extends ObjectLiteral> {
  protected repository: TypeORMRepository<T>;

  constructor(entity: EntityTarget<T>) {
    this.repository = AppDataSource.getRepository<T>(entity);
  }

  public async getAll(
    options?: GetAllOptions<T>,
  ): Promise<{ items: T[]; totalDocs?: number; totalPages?: number }> {
    let { page = 1, limit = 20 } = options?.conditions || {};

    try {
      delete options?.conditions?.page;
      delete options?.conditions?.limit;
      
      const findManyOptions: FindManyOptions = {
        where: options?.conditions,
        skip: (page - 1) * limit,
        take: limit,
        order: options?.order,
        relations: options?.relations
      };
      const [items, totalDocs] = await this.repository.findAndCount(findManyOptions);

      return {
        items,
        totalDocs,
        totalPages: Math.ceil(totalDocs / limit)
      };
    } catch (error) {
      console.log(error);
      // logError(error);
      return { items: [], totalDocs: 0, totalPages: 0 };
    }
  }

  public async createAll(resources: T[]): Promise<T[] | null> {
    try {
      return await this.repository.save(resources);
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async getOneById(id: number): Promise<T | null> {
    try {


      const conditions = { id: id };
      const findOptions: FindOneOptions = { where: conditions };
      return await this.repository.findOne(findOptions);
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async create(resource: T): Promise<T> {
    return await this.repository.save(resource as T);
  }

  public async update(id: number, resource: Partial<T>): Promise<T | null> {
    try {
      let result = await this.repository.update(new ObjectId(id), resource);
      return result.raw;
      // return await this.repository.findOne(id);
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async delete(id: number): Promise<T | null> {
    try {
      const item = await this.repository.delete(new ObjectId(id));
      return item.raw;
      // if (item) {
      //   await this.repository.remove(item);
      // }
      // return item;
    } catch (error) {
      logError(error);
      return null;
    }
  }
}

// import { Document, Model, PopulateOptions, QueryOptions } from 'mongoose';
// import { logError } from '../utils/logger';

// export abstract class Repository<T extends Document> {
//   protected model: Model<T>;

//   constructor(model: Model<T>) {
//     this.model = model;
//   }

//   public async getAll(
//     conditions?: Partial<
//       Record<keyof T, any> &
//       { getAll?: boolean } &
//       { withCount?: boolean } &
//       { page?: number } &
//       { size?: number } &
//       { populate?: string } &
//       { select?: string }
//     >,
//     projection?: Partial<Record<keyof T, any>>,
//     sortOptions?: { [key in keyof T]?: number }
//   ):

//     // IfAny<T, any, Document<unknown, {}, T> & Require_id<T>>
//     Promise<
//       { items: T[], totalDocs?: number, totalPages?: number }
//     > {
//     let page = conditions?.page ?? 1;
//     let size = conditions?.size ?? 20;

//     let populateOptions: PopulateOptions | undefined;
//     if (conditions?.populate) {
//       populateOptions = {
//         path: conditions.populate,
//         select: conditions.select
//       };
//       delete conditions.populate;
//       delete conditions.select;
//     }

//     const options: QueryOptions = {
//       page: page,
//       limit: size,
//       sort: sortOptions,
//       populate: populateOptions
//     };

//     const result = await this.model
//       .find(conditions ?? {}, projection, options)
//       .exec();

//     let answer: any = { items: result };

//     //  Checks if getAll true, then returns all documents with count.
//     if (conditions?.getAll) {
//       const totalDocs = await this.model.countDocuments(conditions);

//       answer.totalDocs = totalDocs;
//       answer.totalPages = Math.ceil(totalDocs / size);
//     }

//     return answer;
//   }

//   public async createAll(resources: T[]): Promise<T[] | null> {
//     try {
//       return await this.model.insertMany(resources);
//     } catch (error) {
//       logError(error);
//       return null;
//     }
//   }
//   public async getOneById(id: string, populate?: string, select?: string): Promise<T | null> {
//     try {
//       if (populate) {
//         let options: PopulateOptions = {
//           path: populate,
//           select: select
//         };

//         return await this.model
//           .findById(id)
//           .populate(options)
//           .exec() as T | null;
//       } else {
//         return await this.model
//           .findById(id)
//           .exec() as T | null;
//       }
//     } catch (error) {
//       logError(error);
//       return null;
//     }
//   }

//   public async create(resource: Partial<T>): Promise<T> {
//     const document = new this.model(resource);
//     let result = await document.save();
//     return result;
//   }

//   public async update(id: string, resource: Partial<T>): Promise<T | null> {
//     return await this.model.findByIdAndUpdate(id, resource, { new: true }).exec();
//   }

//   public async delete(id: string): Promise<T | null> {
//     let result = await this.model.findByIdAndDelete(id).exec();
//     return result.value;
//   }
// }