
// import { Nullable } from "../../../utils/types";
import { LocalizedModel } from "../../../models/base-models";
import { RecitationModel } from "../../../models/recitation-model";
import { Nullable } from "../../../utils/types";

export class RecitationResumedRes {
  public readonly id: Nullable<string>;
  public readonly khatmaId: Nullable<string>;
  public readonly title: LocalizedModel;
  public readonly link: string;
  public readonly image: string;


  constructor(data: RecitationModel) {
    this.id = data.id?.id ?? "";
    this.khatmaId = data.khatmaId?.id ?? "";
    this.title = data.title;
    this.link = data.audio.url;
    this.image = data.image.url;
  }
}
