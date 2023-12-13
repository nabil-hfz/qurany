"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.khatmeRepository = exports.KhatmeRepository = void 0;
const repository_1 = require("../repository");
const http_response_error_1 = require("../../utils/http-response-error");
const reciters_repository_1 = require("../reciter/reciters-repository");
const khatma_model_1 = require("../../models/khatma-model");
class KhatmeRepository extends repository_1.Repository {
    constructor(model, recitersRepository) {
        super(model);
        this.recitersRepository = recitersRepository;
    }
    async createKhatma(request) {
        const reciter = await this.recitersRepository
            .getOneById(request.reciterId);
        if (!reciter || !reciter.id) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterId"');
        }
        const data = {
            name: request.name,
            type: request.type,
            reciter: reciter,
        };
        const result = await this.create(data);
        return { khatmaId: result === null || result === void 0 ? void 0 : result.id };
    }
    async getKhatmaById(khatmaId) {
        const khatmaRes = await this.getOneById(khatmaId);
        if (!khatmaRes || !(khatmaRes === null || khatmaRes === void 0 ? void 0 : khatmaRes.id))
            return null;
        return khatmaRes;
    }
    async getKhatme() {
        const data = await this.getAll({});
        return data;
    }
}
exports.KhatmeRepository = KhatmeRepository;
exports.khatmeRepository = new KhatmeRepository(khatma_model_1.KhatmaModel, reciters_repository_1.recitersRepository);
//# sourceMappingURL=khatme-repository.js.map