"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FileModel = exports.FileModelSchema = void 0;
const mongoose_1 = require("mongoose");
const base_models_1 = require("./base-models");
/**
 * Mongoose schema for the File model.
 * Inherits common fields from BaseModelSchema.
 */
exports.FileModelSchema = new mongoose_1.Schema(Object.assign(Object.assign({}, base_models_1.BaseModelSchema.obj), { url: { type: String, required: true }, size: { type: Number, default: 0, required: true }, mimetype: { type: String, default: undefined }, name: { type: String, default: undefined } }));
/**
 * Mongoose model for the File.
 * Represents documents in the 'File' collection of MongoDB.
 */
exports.FileModel = mongoose_1.default.model('File', exports.FileModelSchema);
// {
//     fieldname: 'images',
//     originalname: 'Slide1.jpg',
//     encoding: '7bit',
//     mimetype: 'image/jpeg',
//     buffer: <Buffer ff d8 ff e0 00 10 4a 46 49 46 00 01 01 01 00 60 00 60 00 00 ff db 00 43 00 03 02 02 03 02 02 03 03 03 03 04 03 03 04 05 08 05 05 04 04 05 0a 07 07 06 ... 145477 more bytes>,
//     size: 145527
//   }
//# sourceMappingURL=file-model.js.map