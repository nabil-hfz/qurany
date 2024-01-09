import { LanguageEntity } from './../../../../db/entities/language.entity';
import { FileEntryEntity } from "../../../../db/entities/file-entiry.entity";
import { Nullable } from "../../../../utils/types";

export class FileEntryResumedRes {
  public readonly id: Nullable<number>;
  public readonly name: Nullable<string>;
  public readonly language: Nullable<LanguageEntity>;
  public readonly file: Nullable<string>;
  public readonly thumbnail: Nullable<string>;
  public readonly totalViews: Nullable<number>;
  public readonly totalDownloads: Nullable<number>;




  constructor(data: FileEntryEntity) {
    this.id = data.id;
    this.name = data.name;
    this.language = data.language;
    this.file = data.file?.url;
    this.thumbnail = data.thumbnail?.url;
    this.totalViews = data.totalViews;
    this.totalDownloads = data.totalDownloads;
  }
}
