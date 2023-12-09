import { ILocalizedModel } from "../../../models/localized-model";
import { IReciterModel } from "../../../models/reciter-models";

export class ReciterResumedRes {
  public readonly id: string;
  public readonly name: ILocalizedModel;
  public readonly image: string;


  constructor(data: IReciterModel) {
    this.id = data.id;
    this.name = data.name;
    this.image = data.image.url;

  }
}
