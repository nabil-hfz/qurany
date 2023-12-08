import { RecitationModel } from "../../../models/recitation-model";
import { Nullable } from "../../../utils/types";
import { RecitationResumedRes } from "./recitation-resumed-res";

export class RecitationFullRes extends RecitationResumedRes {
  public readonly khatmaId: Nullable<string>;
  public readonly totalDownloads: number;
  public readonly totalPlays: number;
  public readonly createdAtMillis: number;
  public readonly duration: number;
  public readonly audioFileSize: number;

  constructor(data: RecitationModel) {
    super(data);
    this.khatmaId = data.khatmaId?.id ?? null;
    this.duration = data.duration;
    this.audioFileSize = data.audio.size;
    this.totalDownloads = data.totalDownloads;
    this.totalPlays = data.totalPlays;
    this.createdAtMillis = data.createdAt.toMillis();
  }
}
