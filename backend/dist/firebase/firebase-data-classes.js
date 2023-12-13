"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DocumentReference = exports.FieldValue = exports.Timestamp = void 0;
const firebase_admin_1 = require("firebase-admin");
// import { firestore } from "firebase-admin";
var Timestamp = firebase_admin_1.firestore.Timestamp;
exports.Timestamp = Timestamp;
var FieldValue = firebase_admin_1.firestore.FieldValue;
exports.FieldValue = FieldValue;
var DocumentReference = firebase_admin_1.firestore.DocumentReference;
exports.DocumentReference = DocumentReference;
//# sourceMappingURL=firebase-data-classes.js.map