import { ReciterModel } from "../../../models/reciter-models";
import { Nullable } from "../../../utils/types";
import { LocalizedModel } from "../../../models/base-models";

export class ReciterResumedRes {
  public readonly id: Nullable<string>;
  public readonly name: LocalizedModel;
  public readonly image: string;


  constructor(data: ReciterModel) {
    this.id = data?.id?.id ?? "";
    this.name = data?.name;
    this.image = data?.image.url ?? data?.image ?? null;

  }
}
