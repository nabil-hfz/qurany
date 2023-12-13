"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.serializeFS = void 0;
const firestore_1 = require("firebase-admin/firestore");
const firestore_2 = require("firebase-admin/firestore");
// import { logError } from "./logger";
/** Serializes a value to a valid Firestore Document data, including object and its childs and Array and its items */
function isDate(value) {
    if (value instanceof Date || value instanceof firestore_2.Timestamp) {
        return true;
    }
    // try {
    //   if (value.toDate() instanceof Date) {
    //     return true;
    //   }
    // } catch (e) {
    //   logError(e);
    //  }
    return false;
}
function serializeFS(value) {
    if (value == null) {
        return null;
    }
    if (typeof value == "boolean" ||
        typeof value == "bigint" ||
        typeof value == "string" ||
        typeof value == "symbol" ||
        typeof value == "number" ||
        isDate(value) ||
        value instanceof firestore_2.FieldValue ||
        value instanceof firestore_1.DocumentReference)
        return value;
    if (Array.isArray(value)) {
        return value.map((v) => serializeFS(v));
    }
    const res = {};
    for (const key of Object.keys(value)) {
        if (value[key] != null)
            res[key] = serializeFS(value[key]);
    }
    return res;
}
exports.serializeFS = serializeFS;
//# sourceMappingURL=serialize-firestore.js.map