import { ILocalizedModel } from "../../../models/localized-model";
import { IReciterModel } from "../../../models/reciter-models";
import { ReciterResumedRes } from "./reciter-resumed-res";

export class ReciterFullRes extends ReciterResumedRes {
  public readonly bio: ILocalizedModel;
  public readonly numberOfKhatmat: number;

  
  constructor(data: IReciterModel) {
    super(data);
    this.bio = data.bio;
    this.numberOfKhatmat = data.numberOfKhatmat;
  }
}
