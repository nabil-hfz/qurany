"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.firebaseDep = void 0;
const functions = require("firebase-functions");
const initialize_1 = require("../firebase/initialize");
const app_const_1 = require("../constant/app.const");
class FirebaseDatasource {
    constructor() {
        this.fireStoreDb = initialize_1.FirebaseApp.firestore();
        this.fireStoreDb.settings({ ignoreUndefinedProperties: true });
    }
    storage() {
        return initialize_1.FirebaseApp.storage();
    }
    database() {
        return initialize_1.FirebaseApp.database;
    }
    auth() {
        return initialize_1.FirebaseApp.auth();
    }
    firestore() {
        return this.fireStoreDb;
    }
    functions() {
        return functions;
    }
    appLogger() {
        return functions.logger;
    }
    handleRequests(app) {
        // functions.https.on
        return functions.region(app_const_1.AppConst.REGION).https.onRequest(app);
    }
}
const firebaseDep = new FirebaseDatasource();
exports.firebaseDep = firebaseDep;
//# sourceMappingURL=firebase-datasource.js.map