"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkIfIsValidCreateAccountReqBody = void 0;
const http_response_error_1 = require("../../../../utils/http-response-error");
const validators_1 = require("../../../../utils/validators");
function checkIfIsValidCreateAccountReqBody(body) {
    var _a, _b;
    if (!((_a = body === null || body === void 0 ? void 0 : body.name) === null || _a === void 0 ? void 0 : _a.length)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'Invalid "name"');
    }
    if (!(0, validators_1.validateEmail)(body === null || body === void 0 ? void 0 : body.email)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'Invalid "email"');
    }
    if (!((_b = body === null || body === void 0 ? void 0 : body.password) === null || _b === void 0 ? void 0 : _b.length) || body.password.length < 6) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'Invalid "password"');
    }
    if ((body === null || body === void 0 ? void 0 : body.role) != "superAdmin" && body.role != "user") {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'Invalid "role", neither "storeOwner" or "buyer"');
    }
}
exports.checkIfIsValidCreateAccountReqBody = checkIfIsValidCreateAccountReqBody;
//# sourceMappingURL=create-account-validation.js.map