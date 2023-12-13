"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkIfIsValidCreateRecitationReqBody = void 0;
const http_response_error_1 = require("../../../../utils/http-response-error");
function checkIfIsValidCreateRecitationReqBody(body) {
    if (!(body === null || body === void 0 ? void 0 : body.reciterIndex)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "reciterIndex" defined');
    }
    if (!(body === null || body === void 0 ? void 0 : body.khatmaId.length)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "khatmaId" defined');
    }
}
exports.checkIfIsValidCreateRecitationReqBody = checkIfIsValidCreateRecitationReqBody;
//# sourceMappingURL=create-recitation-validation.js.map