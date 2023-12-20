import { LocalizedEntity } from "../../../db/entities/localized-entity";
import { ReciterEntity } from "../../../db/entities/reciter-entity";
import { Nullable } from "../../../utils/types";

export class ReciterResumedRes {
  public readonly id: number;
  public readonly numberOfKhatmat: number;
  public readonly name: Nullable<LocalizedEntity>;
  public readonly image: Nullable<string>;


  constructor(data: ReciterEntity) {
    this.id = data.id;
    this.name = data.name;
    this.image = data?.image?.url;
    this.numberOfKhatmat = data.numberOfKhatmat;

  }
}
