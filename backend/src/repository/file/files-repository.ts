import { FileModel, IFileModel } from '../../models/file-model';
import { Repository } from "../repository";
import { Model } from 'mongoose';

export class FilesRepository extends Repository<IFileModel> {

  constructor(model: Model<IFileModel>) {
    super(model);
  }

}

export const filesRepository = new FilesRepository(FileModel);
