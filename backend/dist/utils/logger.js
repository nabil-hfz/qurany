"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.logError = exports.logWarn = exports.logInfo = exports.logEndSuccessRequest = exports.logStartRequest = exports.logDebug = exports.log = void 0;
// import { ErrorReporting } from "@google-cloud/error-reporting";
const firebase_datasource_1 = require("../firebase/firebase-datasource");
function log(message, level = "debug") {
    if (level === "error") {
        console.error(`level is ${level}, message: `, message);
    }
    else {
        console.log(`level is ${level}, message: `, message);
    }
}
exports.log = log;
function logDebug(message) {
    const msg = `${JSON.stringify(message)} debug`;
    log(msg, "debug");
    firebase_datasource_1.firebaseDep.appLogger().debug(msg);
}
exports.logDebug = logDebug;
function logStartRequest(req, controllerName = '', functionName = '') {
    const routePath = '(' + JSON.stringify(req === null || req === void 0 ? void 0 : req.route.path) + ')';
    const routeHeaders = '(' + JSON.stringify(req === null || req === void 0 ? void 0 : req.headers) + ')';
    const routeQuery = '(' + JSON.stringify(req === null || req === void 0 ? void 0 : req.query) + ')';
    const paramQuery = '(' + JSON.stringify(req === null || req === void 0 ? void 0 : req.params) + ')';
    const msg = `Started Router is: ${routePath}. ${controllerName} is triggering func ${functionName} request(${req})`;
    log(msg, "info");
    firebase_datasource_1.firebaseDep.appLogger().info(`Started Router is: ${routePath}. ${controllerName} is triggering func ${functionName}`);
    firebase_datasource_1.firebaseDep.appLogger().info(`Request headers are : ${routeHeaders}`);
    firebase_datasource_1.firebaseDep.appLogger().info(`Request query parameters are : ${routeQuery}`);
    // firebaseDep.appLogger().info(`Request body is : ${req?.body}`); // Horoable print
    firebase_datasource_1.firebaseDep.appLogger().info(`Request params are : ${paramQuery}`);
}
exports.logStartRequest = logStartRequest;
function logEndSuccessRequest(req, controllerName = '', functionName = '') {
    const msg = `Started End is : [${req === null || req === void 0 ? void 0 : req.route}]. ${controllerName} is triggering func ${functionName}`;
    log(msg, "info");
    firebase_datasource_1.firebaseDep.appLogger().info(msg);
}
exports.logEndSuccessRequest = logEndSuccessRequest;
function logInfo(message) {
    const msg = `${(message)} info`;
    log(msg, "info");
    firebase_datasource_1.firebaseDep.appLogger().info(msg);
}
exports.logInfo = logInfo;
function logWarn(message) {
    const msg = `${JSON.stringify(message)} warn`;
    log(msg, "warn");
    firebase_datasource_1.firebaseDep.appLogger().warn(msg);
}
exports.logWarn = logWarn;
function logError(message) {
    const msg = `${JSON.stringify(message)} error`;
    log(msg, "error");
    firebase_datasource_1.firebaseDep.appLogger().error(msg);
    // if (process.env.NODE_ENV === 'prod')
    //   errors.report(`Something broke! ${JSON.stringify(message)}`);
}
exports.logError = logError;
//# sourceMappingURL=logger.js.map