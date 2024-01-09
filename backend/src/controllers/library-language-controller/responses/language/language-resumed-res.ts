import { LanguageEntity } from "../../../../db/entities/language.entity";
import { Nullable } from "../../../../utils/types";

export class LanguageResumedRes {
  public readonly id: Nullable<number>;
  public readonly name: Nullable<string>;



  constructor(data: LanguageEntity) {
    this.id = data.id;
    this.name = data.name;
  }
}
