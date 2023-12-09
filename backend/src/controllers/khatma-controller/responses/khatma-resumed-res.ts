
import { IKhatmaModel } from "../../../models/khatma-model";
import { ILocalizedModel } from "../../../models/localized-model";
import { Nullable } from "../../../utils/types";

export class KhatmaResumedRes {
  public readonly id: Nullable<string>;
  public readonly name: ILocalizedModel;
  // public readonly price:number;

  constructor(data: IKhatmaModel) {
    this.id = data.id ?? "";
    this.name = data.name;
    // this.price = data.price;
  }
}
