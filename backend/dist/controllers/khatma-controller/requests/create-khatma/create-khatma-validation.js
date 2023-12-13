"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkIfIsValidCreateKhatmaReqBody = void 0;
const http_response_error_1 = require("../../../../utils/http-response-error");
function checkIfIsValidCreateKhatmaReqBody(body) {
    // if (!body?.khatmaId.length) {
    //   throw new HttpResponseError(400, "BAD_REQUEST", 'No "khatmaId" defined');
    // }
    var _a;
    if (!((_a = body === null || body === void 0 ? void 0 : body.reciterId) === null || _a === void 0 ? void 0 : _a.length)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "reciterId" defined');
    }
    if (!(body === null || body === void 0 ? void 0 : body.name)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "name" defined');
    }
    if (!(body === null || body === void 0 ? void 0 : body.type)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "type" defined');
    }
}
exports.checkIfIsValidCreateKhatmaReqBody = checkIfIsValidCreateKhatmaReqBody;
//# sourceMappingURL=create-khatma-validation.js.map