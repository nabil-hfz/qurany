import { Nullable } from "../../../../utils/types";
import { CategoryResumedRes } from "./category-resumed-res";
import { FileEntryEntity } from "../../../../db/entities/file-entiry.entity";
import { CategoryEntity } from "../../../../db/entities/category.entity";

export class CategoryFullRes extends CategoryResumedRes {
  public readonly fileEntry: Nullable<FileEntryEntity[]>;
 

  constructor(data: CategoryEntity) {
    super(data);
    this.fileEntry = data.FileEntryEntity;
 
  }
}
