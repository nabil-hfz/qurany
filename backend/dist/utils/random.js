"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.randomString = void 0;
/** Source: https://stackoverflow.com/a/1349426/4508758 */
function randomString(length) {
    let result = "";
    const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}
exports.randomString = randomString;
//# sourceMappingURL=random.js.map