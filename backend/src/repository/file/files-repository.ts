import { EntityTarget } from "typeorm";
import { FileEntity } from "../../db/entities/file-entity";
import { Repository } from "../repository";

export class FilesRepository extends Repository<FileEntity> {

  constructor(model: EntityTarget<FileEntity>) {
    super(model);
  }


  getFileUrlDependingOnPath(path: string): string {
    path = '';
    return path;
  }

}

export const filesRepository = new FilesRepository(FileEntity);
