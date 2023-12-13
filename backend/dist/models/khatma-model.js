"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.KhatmaModel = exports.KhatmaModelSchema = void 0;
const mongoose_1 = require("mongoose");
const base_models_1 = require("./base-models");
const localized_model_1 = require("./localized-model");
exports.KhatmaModelSchema = new mongoose_1.Schema(Object.assign(Object.assign({}, base_models_1.BaseModelSchema.obj), { name: { type: localized_model_1.LocalizedModelSchema, required: true }, type: { type: Number, default: 0 }, totalDownloads: { type: Number, default: 0 }, totalPlays: { type: Number, default: 0 }, reciter: { type: mongoose_1.Schema.Types.ObjectId, ref: 'Reciter', required: true } }));
exports.KhatmaModel = mongoose_1.default.model('Khatma', exports.KhatmaModelSchema);
//# sourceMappingURL=khatma-model.js.map