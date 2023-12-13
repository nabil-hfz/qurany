"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReciterModel = exports.ReciterModelSchema = void 0;
const file_model_1 = require("./file-model");
const mongoose_1 = require("mongoose");
const base_models_1 = require("./base-models");
const localized_model_1 = require("./localized-model");
const recitation_model_1 = require("./recitation-model");
exports.ReciterModelSchema = new mongoose_1.Schema(Object.assign(Object.assign({}, base_models_1.BaseModelSchema.obj), { name: { type: localized_model_1.LocalizedModelSchema, required: true }, bio: { type: localized_model_1.LocalizedModelSchema, required: false }, image: { type: file_model_1.FileModelSchema, required: true }, recitationTypes: { type: [Number], default: [recitation_model_1.RecitationTypes.Hafs] }, totalPlays: { type: Number, default: 0 }, totalDownloads: { type: Number, default: 0 }, numberOfKhatmat: { type: Number, default: 0 } }));
exports.ReciterModel = mongoose_1.default.model('Reciter', exports.ReciterModelSchema);
//# sourceMappingURL=reciter-models.js.map