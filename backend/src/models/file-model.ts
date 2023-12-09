import mongoose, { Schema } from 'mongoose';
import { BaseModelSchema, IBaseModel } from './base-models';

/**
 * Interface for the File model. Extends the base model to include common fields.
 */
export interface IFileModel extends IBaseModel {
    // URL of the file. Required field.
    url: string;

    // Size of the file in bytes. Required field.
    size: number;

    // MIME type of the file, e.g., 'image/jpeg', 'application/pdf'. Optional.
    mimetype?: string;

    // Original name of the file. Optional.
    name?: string;
}

/**
 * Mongoose schema for the File model.
 * Inherits common fields from BaseModelSchema.
 */
export const FileModelSchema = new Schema<IFileModel>({
    ...BaseModelSchema.obj,  // Inherits fields from the base model (like createdAt)
    url: { type: String, required: true },  // File URL
    size: { type: Number, default: 0, required: true },  // File size
    mimetype: { type: String, default: undefined },  // MIME type of the file
    name: { type: String, default: undefined },  // Original name of the file
});

/**
 * Mongoose model for the File.
 * Represents documents in the 'File' collection of MongoDB.
 */
export const FileModel = mongoose.model<IFileModel>('File', FileModelSchema);



// {
//     fieldname: 'images',
//     originalname: 'Slide1.jpg',
//     encoding: '7bit',
//     mimetype: 'image/jpeg',
//     buffer: <Buffer ff d8 ff e0 00 10 4a 46 49 46 00 01 01 01 00 60 00 60 00 00 ff db 00 43 00 03 02 02 03 02 02 03 03 03 03 04 03 03 04 05 08 05 05 04 04 05 0a 07 07 06 ... 145477 more bytes>,
//     size: 145527
//   }
