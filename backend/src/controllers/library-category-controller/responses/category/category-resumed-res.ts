import { CategoryEntity } from "../../../../db/entities/category.entity";
import { LocalizedEntity } from "../../../../db/entities/localized.entity";
import { Nullable } from "../../../../utils/types";

export class CategoryResumedRes {
  public readonly id: Nullable<number>;
  public readonly name: Nullable<LocalizedEntity>;



  constructor(data: CategoryEntity) {
    this.id = data.id ;
    this.name = data.name;
  }
}
