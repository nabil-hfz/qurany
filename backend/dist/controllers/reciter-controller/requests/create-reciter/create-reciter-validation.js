"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkIfIsValidCreateReciterReqBody = void 0;
const http_response_error_1 = require("../../../../utils/http-response-error");
function checkIfIsValidCreateReciterReqBody(body) {
    var _a, _b, _c, _d, _e, _f, _g, _h;
    if (!(body === null || body === void 0 ? void 0 : body.imagePath)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "imagePath" defined ');
    }
    if (!((_b = (_a = body === null || body === void 0 ? void 0 : body.name) === null || _a === void 0 ? void 0 : _a.en) === null || _b === void 0 ? void 0 : _b.length) || !((_d = (_c = body === null || body === void 0 ? void 0 : body.name) === null || _c === void 0 ? void 0 : _c.ar) === null || _d === void 0 ? void 0 : _d.length)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "name en or ar" defined');
    }
    if (!((_f = (_e = body === null || body === void 0 ? void 0 : body.bio) === null || _e === void 0 ? void 0 : _e.en) === null || _f === void 0 ? void 0 : _f.length) || !((_h = (_g = body === null || body === void 0 ? void 0 : body.bio) === null || _g === void 0 ? void 0 : _g.ar) === null || _h === void 0 ? void 0 : _h.length)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'Invalid "bio"');
    }
    if (!(body === null || body === void 0 ? void 0 : body.numberOfKhatmat)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "numberOfKhatmat" defined ');
    }
    if (!(body === null || body === void 0 ? void 0 : body.recitationTypes)) {
        throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No "recitationTypes" defined ');
    }
    // if (!body?.stockQuantity || body.stockQuantity < 0) {
    //   throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "stockQuantity"');
    // }
    // if (!body?.internalCode?.length) {
    //   throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "internalCode"');
    // }
}
exports.checkIfIsValidCreateReciterReqBody = checkIfIsValidCreateReciterReqBody;
//# sourceMappingURL=create-reciter-validation.js.map