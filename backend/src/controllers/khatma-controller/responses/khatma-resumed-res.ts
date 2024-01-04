
import { KhatmaEntity } from "../../../db/entities/khatma.entity";
import { LocalizedEntity } from "../../../db/entities/localized.entity";
import { Nullable } from "../../../utils/types";

export class KhatmaResumedRes {
  public readonly id: Nullable<number>;
  public readonly name: LocalizedEntity;
  public readonly reciter: { name: LocalizedEntity | undefined, image: string | undefined, id: number | undefined };


  constructor(data: KhatmaEntity) {
    this.id = data.id ?? "";
    this.name = data.name;
    this.reciter = {
      name: data.reciter?.name,
      id: data.reciter?.id,
      image: data.reciter?.image?.url,
    }
  }
}
