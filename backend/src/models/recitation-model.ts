import { Schema } from 'mongoose';
import { BaseModelSchema, IBaseModel } from './base-models';
import { IFileModel } from './file-model';
import { ILocalizedModel, LocalizedModelSchema } from './localized-model';
import { IReciterModel } from './reciter-models';


export enum RecitationTypes {
    Hafs = 1,
    Shoaba = 2,
}

interface IRecitationModel extends IBaseModel {
    title: ILocalizedModel;
    //

    image: IFileModel;
    audio: IFileModel;
    reciter: IReciterModel;
    //
    recitationType: number;
    khatmaId: string;
    sequence: number;
    //
    totalDownloads: number;
    totalPlays: number;
    duration: number;
}

export const RecitationModelSchema = new Schema<IRecitationModel>({
    ...BaseModelSchema.obj,
    title: { type: LocalizedModelSchema, required: true },
    //
    image: { type: Schema.Types.ObjectId, ref: 'File', required: true },
    audio: { type: Schema.Types.ObjectId, ref: 'File', required: true },
    reciter: { type: Schema.Types.ObjectId, ref: 'Reciter', required: true },
    // image: { type: FileModelSchema, required: true },
    // audio: { type: FileModelSchema, required: true },
    // reciter: { type: ReciterModelSchema, required: true },
    //
    recitationType: { type: Number, default: RecitationTypes.Hafs },
    khatmaId: { type: String, required: true },
    sequence: { type: Number, default: 0 },
    //
    totalDownloads: { type: Number, default: 0 },
    totalPlays: { type: Number, default: 0 },
    duration: { type: Number, required: true },
});