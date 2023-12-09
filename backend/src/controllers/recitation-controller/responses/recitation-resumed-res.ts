
// import { Nullable } from "../../../utils/types";
import { ILocalizedModel } from "../../../models/localized-model";
import { IRecitationModel } from "../../../models/recitation-model";
import { Nullable } from "../../../utils/types";

export class RecitationResumedRes {
  public readonly id: Nullable<string>;
  public readonly khatmaId: Nullable<string>;
  public readonly title: ILocalizedModel;
  public readonly link: string;
  public readonly image: string;


  constructor(data: IRecitationModel) {
    this.id = data.id?.id ?? "";
    this.khatmaId = data.khatmaId ?? "";
    this.title = data.title;
    this.link = data.audio.url;
    this.image = data.image.url;
  }
}
