"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecitationModel = exports.RecitationModelSchema = exports.RecitationTypes = void 0;
const mongoose_1 = require("mongoose");
const base_models_1 = require("./base-models");
const localized_model_1 = require("./localized-model");
var RecitationTypes;
(function (RecitationTypes) {
    RecitationTypes[RecitationTypes["Hafs"] = 1] = "Hafs";
    RecitationTypes[RecitationTypes["Shoaba"] = 2] = "Shoaba";
})(RecitationTypes = exports.RecitationTypes || (exports.RecitationTypes = {}));
exports.RecitationModelSchema = new mongoose_1.Schema(Object.assign(Object.assign({}, base_models_1.BaseModelSchema.obj), { title: { type: localized_model_1.LocalizedModelSchema, required: true }, 
    //
    image: { type: mongoose_1.Schema.Types.ObjectId, ref: 'File', required: true }, audio: { type: mongoose_1.Schema.Types.ObjectId, ref: 'File', required: true }, reciter: { type: mongoose_1.Schema.Types.ObjectId, ref: 'Reciter', required: true }, 
    // image: { type: FileModelSchema, required: true },
    // audio: { type: FileModelSchema, required: true },
    // reciter: { type: ReciterModelSchema, required: true },
    //
    recitationType: { type: Number, default: RecitationTypes.Hafs }, khatmaId: { type: String, required: true }, sequence: { type: Number, default: 0 }, 
    //
    totalDownloads: { type: Number, default: 0 }, totalPlays: { type: Number, default: 0 }, duration: { type: Number, required: true } }));
exports.RecitationModel = mongoose_1.default.model('Recitation', exports.RecitationModelSchema);
//# sourceMappingURL=recitation-model.js.map