import { LocalizedModel } from "../../../models/base-models";
import { ReciterModel } from "../../../models/reciter-models";
import { ReciterResumedRes } from "./reciter-resumed-res";

export class ReciterFullRes extends ReciterResumedRes {
  public readonly bio: LocalizedModel;
  public readonly numberOfSeals: number;
  public readonly createdAtMillis: number;

  constructor(data: ReciterModel) {
    super(data);
    this.bio = data?.bio;
    this.numberOfSeals = data?.numberOfSeals;
    this.createdAtMillis = data?.createdAt?.toMillis();
  }
}
