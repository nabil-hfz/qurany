import { FileEntryResumedRes } from "./file-entry-resumed-res";
import { FileEntryEntity } from "../../../../db/entities/file-entiry.entity";
import { Nullable } from "../../../../utils/types";

export class FileEntryFullRes extends FileEntryResumedRes {
  public readonly categories: Nullable<{ id: number, name: { [key: string]: string } }[]>;
  public readonly description: Nullable<string>;


  constructor(data: FileEntryEntity) {
    super(data);

    this.categories = data
      .categories
      ?.map(category => ({ id: category.id, name: category.name ?? {} }));

    this.description = data.description;
  }
}
