"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecitationFullRes = void 0;
const recitation_resumed_res_1 = require("./recitation-resumed-res");
class RecitationFullRes extends recitation_resumed_res_1.RecitationResumedRes {
    constructor(data) {
        super(data);
        this.khatmaId = data.khatmaId;
        this.duration = data.duration;
        this.audioFileSize = data.audio.size;
        this.totalDownloads = data.totalDownloads;
        this.totalPlays = data.totalPlays;
        this.createdAtMillis = data.createdAt;
    }
}
exports.RecitationFullRes = RecitationFullRes;
//# sourceMappingURL=recitation-full-res.js.map