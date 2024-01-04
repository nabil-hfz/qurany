import { LocalizedEntity } from "../../../db/entities/localized.entity";
import { RecitationEntity } from "../../../db/entities/recitation.entity";
import { Nullable } from "../../../utils/types";

export class RecitationResumedRes {
  public readonly id: Nullable<number>;
  public readonly khatmaId: Nullable<number>;
  public readonly title: LocalizedEntity;
  public readonly audio: string;
  public readonly image: string;
  public readonly durationInMilli: Nullable<number>;


  constructor(data: RecitationEntity) {
    this.id = data.id ?? "";
    this.khatmaId = data.khatmaId ?? "";
    this.title = data.name;
    this.audio = data.audio.url;
    this.image = data.image.url;
    this.durationInMilli = data.durationInMilli;
  }
}
