"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecitationResumedRes = void 0;
class RecitationResumedRes {
    constructor(data) {
        var _a, _b;
        this.id = (_a = data.id) !== null && _a !== void 0 ? _a : "";
        this.khatmaId = (_b = data.khatmaId) !== null && _b !== void 0 ? _b : "";
        this.title = data.title;
        this.link = data.audio.url;
        this.image = data.image.url;
    }
}
exports.RecitationResumedRes = RecitationResumedRes;
//# sourceMappingURL=recitation-resumed-res.js.map