
import { KhatmaEntity } from "../../../db/entities/khatma.entity";
import { KhatmaResumedRes } from "./khatma-resumed-res";

export class KhatmaFullRes extends KhatmaResumedRes {

  public readonly reciter: any | undefined;
  public readonly totalDownloads: number | undefined;
  public readonly totalPlays: number | undefined;
  // public readonly createdAtMillis?: Date;

  constructor(data: KhatmaEntity) {
    super(data);
    this.totalDownloads = data.totalDownloads;
    this.totalPlays = data.totalPlays;
    this.reciter = {
      name: data?.reciter?.name,
      id: data?.reciter?.id,
      image: data?.reciter?.image?.url
    };
    // this.createdAtMillis = data.createdAt;
  }
}
