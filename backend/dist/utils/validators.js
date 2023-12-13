"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateEmail = void 0;
/** source: https://stackoverflow.com/a/9204568/4508758 */
function validateEmail(email) {
    const re = /\S+@\S+\.\S+/;
    return re.test(email);
}
exports.validateEmail = validateEmail;
//# sourceMappingURL=validators.js.map