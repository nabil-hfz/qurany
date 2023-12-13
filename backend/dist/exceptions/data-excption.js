"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.InvalidDataException = exports.DataException = void 0;
const app_const_1 = require("../constant/app.const");
const errors_1 = require("../utils/errors");
class DataException {
    constructor(errorCode, message, details) {
        this.errorCode = errorCode;
        this.message = message;
        this.details = details;
        this.service = app_const_1.AppConst.SERVICE_NAME;
    }
    toString() {
        `errorCode is ${this.errorCode}, message is ${this.message}, details is ${this.details}`;
        return JSON.stringify(this);
    }
}
exports.DataException = DataException;
class InvalidDataException extends DataException {
    constructor(details) {
        super(errors_1.Errors.INVALID_DATA, "The data is invalid", details);
    }
}
exports.InvalidDataException = InvalidDataException;
//# sourceMappingURL=data-excption.js.map