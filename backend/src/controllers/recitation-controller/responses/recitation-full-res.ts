import { Nullable } from "../../../utils/types";
import { RecitationResumedRes } from "./recitation-resumed-res";
import { RecitationEntity } from '../../../db/entities/recitation-entity';

export class RecitationFullRes extends RecitationResumedRes {
  public readonly khatmaId: Nullable<number>;
  public readonly totalDownloads: number;
  public readonly totalPlays: number;
  public readonly createdAt?: Date;
  public readonly audioFileSizeInByte: number;

  constructor(data: RecitationEntity) {
    super(data);
    this.khatmaId = data.khatmaId;
    this.audioFileSizeInByte = data.audio.size;
    this.totalDownloads = data.totalDownloads;
    this.totalPlays = data.totalPlays;
    this.createdAt = data.createdAt;
  }
}
