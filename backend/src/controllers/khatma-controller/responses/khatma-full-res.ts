
import { IFileModel } from "../../../models/file-model";
import { IKhatmaModel } from "../../../models/khatma-model";
import { ILocalizedModel } from "../../../models/localized-model";
import { KhatmaResumedRes } from "./khatma-resumed-res";

export class KhatmaFullRes extends KhatmaResumedRes {

  public readonly reciter: { name: ILocalizedModel, image: IFileModel, id: any };
  public readonly totalDownloads: number;
  public readonly totalPlays: number;
  public readonly createdAtMillis?: Date;

  constructor(data: IKhatmaModel) {
    super(data);
    this.reciter = {
      name: data.reciter.name,
      image: data.reciter.image,
      id: data.reciter?.id,
    };
    this.totalDownloads = data.totalDownloads;
    this.totalPlays = data.totalPlays;

    this.createdAtMillis = data.createdAt;
  }
}
