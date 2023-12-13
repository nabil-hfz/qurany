"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReciterFullRes = void 0;
const reciter_resumed_res_1 = require("./reciter-resumed-res");
class ReciterFullRes extends reciter_resumed_res_1.ReciterResumedRes {
    constructor(data) {
        super(data);
        this.bio = data.bio;
        this.numberOfKhatmat = data.numberOfKhatmat;
    }
}
exports.ReciterFullRes = ReciterFullRes;
//# sourceMappingURL=reciter-full-res.js.map