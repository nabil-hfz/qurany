"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.accountsService = void 0;
const admin = require("firebase-admin");
const http_response_error_1 = require("../utils/http-response-error");
class AccountsService {
    async createAccount(role, name, email, password) {
        let createUserRes;
        try {
            createUserRes = await admin.auth().createUser({
                displayName: name,
                email: email,
                password: password,
            });
        }
        catch (e) {
            switch (e.code) {
                case "auth/email-already-exists":
                    throw new http_response_error_1.HttpResponseError(400, "EXISTING_EMAIL", "Email is already in use");
            }
            throw e;
        }
        await admin.auth().setCustomUserClaims(createUserRes.uid, {
            storeOwner: role == "superAdmin",
            buyer: role == "user", // true or false
        });
        return admin.auth().getUser(createUserRes.uid);
    }
}
exports.accountsService = new AccountsService();
//# sourceMappingURL=accounts-service.js.map