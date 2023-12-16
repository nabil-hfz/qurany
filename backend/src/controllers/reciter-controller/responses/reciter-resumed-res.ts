import { LocalizedEntity } from "../../../db/entities/localized-entity";
import { ReciterEntity } from "../../../db/entities/reciter-entity";

export class ReciterResumedRes {
  public readonly id: number;
  public readonly name: LocalizedEntity;
  public readonly image: string;


  constructor(data: ReciterEntity) {
    this.id = data.id;
    this.name = data.name;
    this.image = data.image.url;

  }
}
