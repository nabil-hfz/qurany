"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LocalizedModelSchema = void 0;
const mongoose_1 = require("mongoose");
exports.LocalizedModelSchema = new mongoose_1.Schema({
    ar: { type: String, required: true },
    en: { type: String, required: true }
});
//# sourceMappingURL=localized-model.js.map