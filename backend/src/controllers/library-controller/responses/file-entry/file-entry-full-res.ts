import { Nullable } from "../../../../utils/types";
import {  FileEntryResumedRes } from "./file-entry-resumed-res";
import { FileEntryEntity } from "../../../../db/entities/file-entiry.entity";
import { CategoryEntity } from "../../../../db/entities/category.entity";

export class FileEntryFullRes extends FileEntryResumedRes {
  public readonly fileEntry: Nullable<FileEntryEntity[]>;
 

  constructor(data: CategoryEntity) {
    super(data);
    this.fileEntry = data.FileEntryEntity;
 
  }
}
