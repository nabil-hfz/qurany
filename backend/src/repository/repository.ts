
import { Repository as TypeORMRepository, EntityTarget, ObjectLiteral, FindOneOptions, ObjectId, FindManyOptions } from 'typeorm';
import { logError } from '../utils/logger';
import { AppPagination } from '../middlewares/pagination.middleware';
import dataSource from '../db/data-source';

export interface GetAllOptions<T> {
  conditions?: Partial<T> & Partial<AppPagination>,
  order?: { [P in keyof T]?: 'ASC' | 'DESC' },
  relations?: { [P in keyof T]?: boolean },
}


export abstract class Repository<T extends ObjectLiteral> {
  protected _repository: TypeORMRepository<T>;

  constructor(entity: EntityTarget<T>) {
    this._repository = dataSource.getRepository<T>(entity);
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
      const [items, totalDocs] = await this._repository.findAndCount(findManyOptions);

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
      return await this._repository.save(resources);
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async getOneById(id: number): Promise<T | null> {
    try {


      const conditions = { id: id };
      const findOptions: FindOneOptions = { where: conditions };
      return await this._repository.findOne(findOptions);
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async create(resource: T): Promise<T> {
    return await this._repository.save(resource as T);
  }

  public async update(id: number, resource: Partial<T>): Promise<T | null> {
    try {
      let result = await this._repository.update(new ObjectId(id), resource);
      return result.raw;
      // return await this.repository.findOne(id);
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async delete(id: number): Promise<boolean> {
    try {
      const item = await this._repository.delete(id);

      console.log(item);

      return (item.affected ?? 0) > 0;
    } catch (error) {
      logError(error);
      return false;
    }
  }
}