"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FirebaseApp = exports.CURRENT_GCLOUD_PROJECT = void 0;
const admin = require("firebase-admin");
const path = require("path");
const config_1 = require("../config");
// import * as admin2 from "./qurany-firebase-adminsdk.json";
// import * as admin from "firebase-admin";
// const FirebaseApp: admin.app.App;
// /Users/nabil.alhafez/Node-Js/QuranyBackend/functions/qurany-firebase-adminsdk.json
// /Users/nabil.alhafez/Node-Js/QuranyBackend/functions/qurany-firebase-adminsdk.json
//     firebase: {
//         databaseURL: `https://${process.env.GCLOUD_PROJECT}.firebaseio.com`,
//         storageBucket: `gs://${process.env.GCLOUD_PROJECT}.appspot.com`
//     }
exports.CURRENT_GCLOUD_PROJECT = process.env.GCLOUD_PROJECT;
console.log(`project CURRENT_GCLOUD_PROJECT (${exports.CURRENT_GCLOUD_PROJECT}) config loaded`);
const serviceAccoun = path.resolve(process.cwd(), `./.key/qurany-firebase-adminsdk-${config_1.currentEnv}.json`);
console.log('serviceAccoun is ', serviceAccoun);
const credential = admin.credential.cert(serviceAccoun);
const FirebaseApp = admin.initializeApp({
    credential: credential,
    storageBucket: `${exports.CURRENT_GCLOUD_PROJECT}.appspot.com`,
    databaseURL: `https://${exports.CURRENT_GCLOUD_PROJECT}.firebaseio.com`,
});
exports.FirebaseApp = FirebaseApp;
//# sourceMappingURL=initialize.js.map