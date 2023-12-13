"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.KhatmaFullRes = void 0;
const khatma_resumed_res_1 = require("./khatma-resumed-res");
class KhatmaFullRes extends khatma_resumed_res_1.KhatmaResumedRes {
    constructor(data) {
        var _a;
        super(data);
        this.reciter = {
            name: data.reciter.name,
            image: data.reciter.image,
            id: (_a = data.reciter) === null || _a === void 0 ? void 0 : _a.id,
        };
        this.totalDownloads = data.totalDownloads;
        this.totalPlays = data.totalPlays;
        this.createdAtMillis = data.createdAt;
    }
}
exports.KhatmaFullRes = KhatmaFullRes;
//# sourceMappingURL=khatma-full-res.js.map