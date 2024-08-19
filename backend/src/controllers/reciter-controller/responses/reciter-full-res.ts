// import { LocalizedEntity } from "../../../db/entities/localized.entity";
import { ReciterEntity } from "../../../db/entities/reciter.entity";
import { ReciterResumedRes } from "./reciter-resumed-res";

export class ReciterFullRes extends ReciterResumedRes {
  public readonly bio: { [key: string]: string } | undefined;


  constructor(data: ReciterEntity) {
    super(data);
    this.bio = data.bio;
  }
}
