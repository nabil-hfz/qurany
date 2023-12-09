

import mongoose, { Schema } from 'mongoose';
import { BaseModelSchema, IBaseModel } from './base-models';
import { ILocalizedModel, LocalizedModelSchema } from './localized-model';

interface IKhatmaModel extends IBaseModel {
    name: ILocalizedModel;
    type: number;
    totalDownloads: number;
    totalPlays: number;
}

export const KhatmaModelSchema = new Schema<IKhatmaModel>({
    ...BaseModelSchema.obj,
    name: { type: LocalizedModelSchema, required: true },
    type: { type: Number, default: 0 },
    totalDownloads: { type: Number, default: 0 },
    totalPlays: { type: Number, default: 0 },
});


export const KhatmaModel = mongoose.model<IKhatmaModel>('Khatma', KhatmaModelSchema);
