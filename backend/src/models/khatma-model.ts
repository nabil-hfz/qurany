

import mongoose, { Schema } from 'mongoose';
import { BaseModelSchema, IBaseModel } from './base-models';
import { ILocalizedModel, LocalizedModelSchema } from './localized-model';
import { IReciterModel } from './reciter-models';

export interface IKhatmaModel extends IBaseModel {
    name: ILocalizedModel;
    type: number;
    totalDownloads: number;
    totalPlays: number;
    reciter: IReciterModel;
}

export const KhatmaModelSchema = new Schema<IKhatmaModel>({
    ...BaseModelSchema.obj,
    name: { type: LocalizedModelSchema, required: true },
    type: { type: Number, default: 0 },
    totalDownloads: { type: Number, default: 0 },
    totalPlays: { type: Number, default: 0 },
    reciter: { type: Schema.Types.ObjectId, ref: 'Reciter', required: true },

});


export const KhatmaModel = mongoose.model<IKhatmaModel>('Khatma', KhatmaModelSchema);
