"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.recitersRepository = exports.RecitersRepository = void 0;
const reciter_models_1 = require("../../models/reciter-models");
const repository_1 = require("../repository");
const http_response_error_1 = require("../../utils/http-response-error");
const recitation_model_1 = require("../../models/recitation-model");
const files_repository_1 = require("../file/files-repository");
class RecitersRepository extends repository_1.Repository {
    constructor(model, filesRepository) {
        super(model);
        this.filesRepository = filesRepository;
    }
    async createReciter(request, image) {
        const imgResult = await this.filesRepository.create(image);
        const data = {
            name: request.name,
            bio: request.bio,
            image: imgResult,
            numberOfKhatmat: request.numberOfKhatmat,
            recitationTypes: [recitation_model_1.RecitationTypes.Hafs]
        };
        const reciter = this.create(data);
        return reciter;
    }
    async getReciters() {
        const reciters = this.getAll({});
        return reciters;
    }
    async getReciterById(reciterId) {
        const reciterRes = await this.getOneById(reciterId);
        console.log(reciterRes);
        if (!reciterRes || !(reciterRes === null || reciterRes === void 0 ? void 0 : reciterRes.id)) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", `No reciter found with this \"reciterId\": ${reciterId}`);
        }
        return reciterRes;
    }
}
exports.RecitersRepository = RecitersRepository;
exports.recitersRepository = new RecitersRepository(reciter_models_1.ReciterModel, files_repository_1.filesRepository);
//# sourceMappingURL=reciters-repository.js.map