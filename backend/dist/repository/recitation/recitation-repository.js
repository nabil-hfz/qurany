"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.recitationRepository = exports.RecitationRepository = void 0;
const repository_1 = require("../repository");
const collections_1 = require("../../firebase/collections");
const recitation_model_1 = require("../../models/recitation-model");
const http_response_error_1 = require("../../utils/http-response-error");
const uploader_service_1 = require("../../services/uploader-service");
const logger_1 = require("../../utils/logger");
const files_repository_1 = require("../file/files-repository");
class RecitationRepository extends repository_1.Repository {
    constructor(model, filesRepository) {
        super(model);
        this.filesRepository = filesRepository;
    }
    async createRecitations(request, images, audios) {
        var _a;
        const khatmaId = request.khatmaId;
        const reciterIndex = request.reciterIndex;
        const currentFilesPath = collections_1.statusLables[reciterIndex];
        const audiosPath = collections_1.AppFirebaseCollections.audiosStoragePath + currentFilesPath;
        const imagesPath = collections_1.AppFirebaseCollections.imagesStoragePath + currentFilesPath;
        (0, logger_1.logInfo)('khatmaId is: ' + khatmaId);
        (0, logger_1.logInfo)('audiosPath is: ' + audiosPath);
        (0, logger_1.logInfo)('imagesPath is: ' + imagesPath);
        const filesResult = await uploader_service_1.uploaderService
            .handleFiles(images, audios, audiosPath, imagesPath);
        if (!filesResult || !filesResult.length) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No files found "filesResult"');
        }
        const khatma = await this.getOneById(khatmaId);
        if (!khatma || !(khatma === null || khatma === void 0 ? void 0 : khatma.id)) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No khatma found with this "khatmaId"');
        }
        const reciter = khatma.reciter;
        const reciterId = reciter.id;
        if (!reciter || !reciterId || !(reciterId === null || reciterId === void 0 ? void 0 : reciterId.length)) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "khatmaId"');
        }
        let index = 0;
        const docs = (_a = filesResult.map((data) => {
            index += 1;
            return {
                audio: data.audioFile,
                duration: data.duration,
                image: data.imageFile,
                title: {
                    en: `Chapter ${index}`,
                    ar: `الجزء ${index}`,
                },
                sequence: index,
                reciter: reciter,
                khatmaId: khatmaId,
            };
        })) !== null && _a !== void 0 ? _a : [];
        const imgs = docs.map(recitation => recitation.image);
        const auds = docs.map(recitation => recitation.audio);
        await this.filesRepository.createAll(imgs);
        await this.filesRepository.createAll(auds);
        const savedRecitation = await this.createAll(docs);
        const temp = savedRecitation === null || savedRecitation === void 0 ? void 0 : savedRecitation.map(recitation => ({
            id: recitation === null || recitation === void 0 ? void 0 : recitation.id,
            audio: recitation === null || recitation === void 0 ? void 0 : recitation.audio.url,
            image: recitation === null || recitation === void 0 ? void 0 : recitation.image.url,
            title: recitation === null || recitation === void 0 ? void 0 : recitation.title,
        }));
        return temp;
    }
    async getRecitationById(recitationId) {
        const recitationRes = await this.getOneById(recitationId);
        if (!recitationRes || !(recitationRes === null || recitationRes === void 0 ? void 0 : recitationRes.id)) {
            return null;
        }
        return recitationRes;
    }
    async getRecitations() {
        return await this.getAll({});
    }
}
exports.RecitationRepository = RecitationRepository;
exports.recitationRepository = new RecitationRepository(recitation_model_1.RecitationModel, files_repository_1.filesRepository);
//# sourceMappingURL=recitation-repository.js.map