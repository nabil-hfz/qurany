"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ErrorResponseBody = exports.HttpResponseError = void 0;
class HttpResponseError extends Error {
    constructor(status, code = "UNKNOWN", description = `An error occurred with status "${status}" and code "${code}"`, internalLog = description) {
        super(`(HttpResponseError) status: "${status}" code: "${code}" description: "${description}"`);
        this.status = status;
        this.code = code;
        this.description = description;
        this.internalLog = internalLog;
        if (status && status < 400) {
            throw Error(`HttpResponseError: invalid error, status is "${status}"`);
        }
    }
}
exports.HttpResponseError = HttpResponseError;
class ErrorResponseBody {
    constructor(error) {
        this.error = error;
    }
}
exports.ErrorResponseBody = ErrorResponseBody;
//# sourceMappingURL=http-response-error.js.map