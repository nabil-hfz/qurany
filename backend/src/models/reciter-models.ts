import { FileModelSchema, IFileModel } from "./file-model";
import mongoose, { Schema } from 'mongoose';
import { BaseModelSchema, IBaseModel } from './base-models';
import { ILocalizedModel, LocalizedModelSchema } from './localized-model';
import { RecitationTypes } from "./recitation-model";

export interface IReciterModel extends IBaseModel {
  name: ILocalizedModel;
  bio: ILocalizedModel;
  image: IFileModel;
  recitationTypes: number[];
  totalPlays: number;
  totalDownloads: number;
  numberOfKhatmat: number;
}

export const ReciterModelSchema = new Schema<IReciterModel>({
  ...BaseModelSchema.obj,
  name: { type: LocalizedModelSchema, required: true },
  bio: { type: LocalizedModelSchema, required: false },
  image: { type: FileModelSchema, required: true },
  recitationTypes: { type: [Number], default: [RecitationTypes.Hafs] },
  totalPlays: { type: Number, default: 0 },
  totalDownloads: { type: Number, default: 0 },
  numberOfKhatmat: { type: Number, default: 0 },
});

export const ReciterModel = mongoose.model<IReciterModel>('Reciter', ReciterModelSchema);
