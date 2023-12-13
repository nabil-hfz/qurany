"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.verifyValidFirebaseUidTokenInterceptor = void 0;
const admin = require("firebase-admin");
// import * as assert from "node:assert";
const http_response_error_1 = require("../utils/http-response-error");
const verifyValidFirebaseUidTokenInterceptor = (req, res, next) => {
    var _a, _b;
    const authorizationHeaderValue = (_b = (((_a = req.headers["Authorization"]) === null || _a === void 0 ? void 0 : _a.length)
        ? req.headers["Authorization"]
        : req.headers["authorization"])) === null || _b === void 0 ? void 0 : _b.toString();
    if (!(authorizationHeaderValue === null || authorizationHeaderValue === void 0 ? void 0 : authorizationHeaderValue.length)) {
        req.authenticated = false;
        next();
        return;
    }
    let finished = false;
    setTimeout(() => {
        if (!finished) {
            finished = true;
            res.status(401).send(new http_response_error_1.ErrorResponseBody({
                status: 401,
                code: "UNAUTHORIZED",
                description: "Invalid 'Authorization' token (timeout)",
            }));
        }
    }, 2500);
    if (authorizationHeaderValue.startsWith("Bearer ")) {
        const firebaseAuthToken = authorizationHeaderValue.substring("Bearer ".length);
        admin
            .auth()
            .verifyIdToken(firebaseAuthToken, true)
            .then(async (decoded) => {
            if (!finished) {
                finished = true;
                req.authenticated = true;
                req.auth = await admin.auth().getUser(decoded.uid);
                req.token = decoded;
                // assert(req.auth != null);
                // assert(req.token != null);
                next();
            }
        }, (reason) => {
            console.error(`Invalid 'Authorization' token: ${reason}`);
            if (!finished) {
                finished = true;
                res.status(401).send(new http_response_error_1.ErrorResponseBody({
                    status: 401,
                    code: "UNAUTHORIZED",
                    description: "Invalid 'Authorization' token",
                }));
            }
        });
    }
    else {
        res.status(400).send(new http_response_error_1.ErrorResponseBody({
            status: 400,
            code: "BAD_REQUEST",
            description: "Invalid 'Authorization' header value, should be: 'Bearer <token>'",
        }));
    }
};
exports.verifyValidFirebaseUidTokenInterceptor = verifyValidFirebaseUidTokenInterceptor;
//# sourceMappingURL=verify-valid-firebase-uid-token-interceptor.js.map