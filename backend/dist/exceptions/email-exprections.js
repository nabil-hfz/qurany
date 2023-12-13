"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmailRejectedException = void 0;
const errors_1 = require("../utils/errors");
const data_excption_1 = require("./data-excption");
class EmailRejectedException extends data_excption_1.DataException {
    constructor(details) {
        super(errors_1.Errors.REJECT_EMAIL, "The email has been rejected ", details);
    }
}
exports.EmailRejectedException = EmailRejectedException;
//# sourceMappingURL=email-exprections.js.map