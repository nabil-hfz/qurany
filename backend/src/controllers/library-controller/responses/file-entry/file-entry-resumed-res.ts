import { FileEntryEntity } from "../../../../db/entities/file-entiry.entity";
import { Nullable } from "../../../../utils/types";

export class FileEntryResumedRes {
  public readonly id: Nullable<number>;
  public readonly name: Nullable<string>;
  public readonly language: { name: Nullable<string>, id: Nullable<number> };
  public readonly file: Nullable<string>;
  public readonly thumbnail: Nullable<string>;
  public readonly totalViews: Nullable<number>;
  public readonly totalDownloads: Nullable<number>;




  constructor(data: FileEntryEntity) {
    this.id = data.id;
    this.name = data.name;
    this.language = { id: data.language?.id, name: data.language?.name };
    this.file = data.file?.url;
    this.thumbnail = data.thumbnail?.url;
    this.totalViews = data.totalViews;
    this.totalDownloads = data.totalDownloads;
  }
}
