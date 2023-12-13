"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.HttpServer = void 0;
const http_response_error_1 = require("../utils/http-response-error");
const logger_1 = require("../utils/logger");
const multer = require("multer");
const upload = multer();
class HttpServer {
    constructor(express) {
        this.express = express;
        this._catchErrorHandler = (requestHandler, customClaims) => {
            return async (req, res, next) => {
                var _a, _b;
                const checkCustomClaim = () => {
                    var _a;
                    if (customClaims === null || customClaims === void 0 ? void 0 : customClaims.length) {
                        // assert(req.authenticated != null);
                        // assert(req.auth != null);
                        if (!req.authenticated) {
                            throw new http_response_error_1.HttpResponseError(403, "FORBIDDEN", "You should be authenticated on a Firebase Auth account that have this/these custom claims: " +
                                customClaims);
                        }
                        for (const claim of customClaims) {
                            if (((_a = req.auth.customClaims) !== null && _a !== void 0 ? _a : {})[claim]) {
                                return;
                            }
                        }
                        throw new http_response_error_1.HttpResponseError(403, "FORBIDDEN", `Only ${customClaims.toString().replace(/,/g, ", ")} can access`);
                    }
                };
                try {
                    checkCustomClaim.toString();
                    // checkCustomClaim();
                    // noinspection ES6RedundantAwait
                    await Promise.resolve(requestHandler(req, res, next));
                }
                catch (e) {
                    const userInfo = !((_b = (_a = req.auth) === null || _a === void 0 ? void 0 : _a.uid) === null || _b === void 0 ? void 0 : _b.length) ? "" : ` uid: ${req.auth.uid}`;
                    if (e instanceof http_response_error_1.HttpResponseError) {
                        (0, logger_1.logWarn)(`[${req.method.toUpperCase()}] ${req.path}${userInfo} - ${e.internalLog}`);
                        res.statusCode = e.status;
                        res.send(new http_response_error_1.ErrorResponseBody({
                            status: e.status,
                            code: e.code,
                            description: e.description,
                        }));
                        // next();
                        return;
                    }
                    console.error('Error happened ', e);
                    // logError(`[${req.method.toUpperCase()}] ${req.path}${userInfo}`);
                    // logError(e.stack);
                    // logError.toString();
                    res.statusCode = 500;
                    res.send(new http_response_error_1.ErrorResponseBody({
                        status: 500,
                        code: "INTERNAL_ERROR",
                        description: "An internal error occurred, please contact support " + e,
                    }));
                    return;
                    next();
                }
            };
        };
    }
    get(params) {
        this.express.get(params.path, this._catchErrorHandler(params.requestHandler, params.customClaims));
    }
    post(param) {
        if (param.fileFields && param.fileFields.length > 0) {
            this.express.post(param.path, upload.fields(param.fileFields), this._catchErrorHandler(param.requestHandler, param.customClaims));
        }
        else {
            this.express.post(param.path, this._catchErrorHandler(param.requestHandler, param.customClaims));
        }
    }
    delete(path, requestHandler, customClaims) {
        this.express.delete(path, this._catchErrorHandler(requestHandler, customClaims));
    }
    put(path, requestHandler, customClaims) {
        this.express.put(path, this._catchErrorHandler(requestHandler, customClaims));
    }
}
exports.HttpServer = HttpServer;
//# sourceMappingURL=index.js.map