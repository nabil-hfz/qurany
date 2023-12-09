
import { Schema, Document } from 'mongoose';


export interface IBaseModel extends Document {
  createdAt?: Date;
  updatedAt?: Date;
}

export const BaseModelSchema = new Schema<IBaseModel>({
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: undefined }
}, {
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

BaseModelSchema.virtual('id').get(function () {
  return this._id.toHexString();
});


// BaseModelSchema.set('toJSON', {
//   virtuals: true
// });
