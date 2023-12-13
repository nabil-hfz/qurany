"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.interceptors = void 0;
const verify_valid_firebase_uid_token_interceptor_1 = require("./verify-valid-firebase-uid-token-interceptor");
const instantiate_cache_interceptor_1 = require("./instantiate-cache-interceptor");
exports.interceptors = [instantiate_cache_interceptor_1.instantiateCacheInterceptor, verify_valid_firebase_uid_token_interceptor_1.verifyValidFirebaseUidTokenInterceptor];
//# sourceMappingURL=index.js.map