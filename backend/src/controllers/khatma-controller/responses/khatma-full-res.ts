import { LocalizedModel } from "../../../models/base-models";
import { MiniFileModel } from "../../../models/file-model";
import { KhatmaModel } from "../../../models/khatma-model";
import { KhatmaResumedRes } from "./khatma-resumed-res";

export class KhatmaFullRes extends KhatmaResumedRes {
  // public readonly internalCode:string;
  public readonly reciter: { name: LocalizedModel, image: MiniFileModel, id: any };
  public readonly createdAtMillis: number;
  public readonly totalDownloads: number;
  public readonly totalPlays: number;

  constructor(data: KhatmaModel) {
    super(data, data?.id?.id ?? '');
    this.reciter =
    {
      name: data.reciter.name,
      image: data.reciter.image,
      id: data.reciter?.id?.id ?? ''
    };
    this.totalDownloads = data.totalDownloads;
    this.totalPlays = data.totalPlays;

    this.createdAtMillis = data.createdAt.toMillis();
  }
}
