import { Document, Model } from 'mongoose';
import { logError } from '../utils/logger';

export abstract class Repository<T extends Document> {
  protected model: Model<T>;

  constructor(model: Model<T>) {
    this.model = model;
  }

  public async getAll(
    conditions: Partial<Record<keyof T, any> & { getAll?: boolean } & { withCount?: boolean }>,
    page: number = 1,
    size: number = 20,
    projection?: Partial<Record<keyof T, any>>,
    sortOptions?: { [key in keyof T]?: number }
  ):
    // IfAny<T, any, Document<unknown, {}, T> & Require_id<T>>
    Promise<
      { items: T[], totalDocs?: number, totalPages?: number }
    > {
    const options = {
      page: page,
      limit: size,
      sort: sortOptions
    };

    const result = await this.model
      .find(conditions, projection, options)
      .exec();

    let answer: any = { items: result };

    //  Checks if getAll true, then returns all documents with count.
    if (conditions.getAll) {
      const totalDocs = await this.model.countDocuments(conditions);

      answer.totalDocs = totalDocs;
      answer.totalPages = Math.ceil(totalDocs / size);
    }

    return answer;
  }

  public async createAll(resources: T[]): Promise<T[] | null> {
    try {
      return await this.model.insertMany(resources);
    } catch (error) {
      logError(error);
      return null;
    }
  }
  public async getOneById(id: string): Promise<T | null> {
    try {
      return await this.model.findById(id).exec();
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async create(resource: Partial<T>): Promise<T> {
    const document = new this.model(resource);
    let result = await document.save();
    return result;
  }

  public async update(id: string, resource: Partial<T>): Promise<T | null> {
    return await this.model.findByIdAndUpdate(id, resource, { new: true }).exec();
  }

  public async delete(id: string): Promise<T | null> {
    let result = await this.model.findByIdAndDelete(id).exec();
    return result.value;
  }
}
