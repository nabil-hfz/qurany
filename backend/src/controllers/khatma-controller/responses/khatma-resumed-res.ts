
// import { Nullable } from "../../../utils/types";
import { LocalizedModel } from "../../../models/base-models";
import { KhatmaModel } from "../../../models/khatma-model";
import { Nullable } from "../../../utils/types";

export class KhatmaResumedRes {
  public readonly id: Nullable<string>;
  public readonly name: LocalizedModel;
  // public readonly price:number;

  constructor(data: KhatmaModel, id?: string) {
    this.id = id ?? "";
    this.name = data.name;
    // this.price = data.price;
  }
}
