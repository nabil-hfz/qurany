import { Model } from 'mongoose';
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
    Promise<{ data: T[] } |
    { data: T[], totalDocs: number } |
    { data: T[], totalPages: number } |
    { data: T[], totalDocs: number, totalPages: number }> {
    const options = {
      page: page,
      limit: size,
      sort: sortOptions
    };

    const result = await this.model
      .find(conditions, projection, options)
      .exec();

    let answer: any = { data: result };

    //  Checks if getAll true, then returns all documents with count.
    if (conditions.getAll) {
      const totalDocs = await this.model.countDocuments(conditions);

      answer.totalDocs = totalDocs;
      answer.totalPages = Math.ceil(totalDocs / size);
    }

    return answer;
  }

  public async getDocument(id: string): Promise<T | null> {
    try {
      return await this.model.findOne().findById(id).exec();
    } catch (error) {
      logError(error);
      return null;
    }
  }

  public async create(resource: Partial<T>): Promise<T> {
    const document = new this.model(resource);
    return await document.save();
  }

  public async update(id: string, resource: Partial<T>): Promise<T | null> {
    return await this.model.findByIdAndUpdate(id, resource, { new: true }).exec();
  }

  public async delete(id: string): Promise<T | null> {
    let result = await this.model.findByIdAndDelete(id).exec();
    return result.value;
  }
}
