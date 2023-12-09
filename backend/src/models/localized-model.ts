
import { Schema, Document } from 'mongoose';

export interface ILocalizedModel extends Document {
    ar?: string;
    en?: string;
}

export const LocalizedModelSchema = new Schema<ILocalizedModel>({
    ar: { type: String, required: true },
    en: { type: String, required: true }
});

