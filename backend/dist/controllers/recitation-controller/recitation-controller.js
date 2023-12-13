"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RecitationController = void 0;
const app_const_1 = require("../../constant/app.const");
const logger_1 = require("../../utils/logger");
const collections_1 = require("../../firebase/collections");
const create_recitation_validation_1 = require("./requests/create-recitation/create-recitation-validation");
const recitation_repository_1 = require("../../repository/recitation/recitation-repository");
const recitation_resumed_res_1 = require("./responses/recitation-resumed-res");
const recitation_list_resumed_res_1 = require("./responses/recitation-list-resumed-res");
const http_response_error_1 = require("../../utils/http-response-error");
const recitation_full_res_1 = require("./responses/recitation-full-res");
class RecitationController {
    constructor() {
        this.url = `${app_const_1.AppConst.AppFunctionVersion1}${collections_1.AppRoutes.recitationsRoute}`;
        this.createRecitations = async (req, res, next) => {
            (0, logger_1.logStartRequest)(req, 'RecitationController', 'createRecitations');
            const reqBody = Object.assign({}, req.body);
            (0, create_recitation_validation_1.checkIfIsValidCreateRecitationReqBody)(reqBody);
            const reciterIndex = reqBody.reciterIndex;
            const currentFilesPath = collections_1.statusLables[reciterIndex];
            if (reciterIndex >= collections_1.statusLables.length || !currentFilesPath) {
                throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterIndex"');
            }
            const audios = req.files['audios'];
            if (!audios || !audios.length) {
                throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No files found "audios"');
            }
            const images = req.files['images'];
            if (!images || !images.length) {
                throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", 'No files found "images"');
            }
            const result = await recitation_repository_1.recitationRepository
                .createRecitations(reqBody, images, audios);
            (0, logger_1.logEndSuccessRequest)(req, 'RecitationController', 'createRecitations');
            res.status(200).send({
                message: 'Recitations created successfully',
                recitations: result,
            });
            next();
        };
        this.getFilePathPublic = async (req, res, next) => {
            res.status(200).send(collections_1.statusLables
                .map((filePath, index) => {
                return {
                    index,
                    audiosPath: collections_1.AppFirebaseCollections.audiosStoragePath + filePath,
                    iamgesPath: collections_1.AppFirebaseCollections.imagesStoragePath + filePath,
                };
            }));
            next();
        };
        this.getRecitationListPublic = async (req, res, next) => {
            const recitations = await recitation_repository_1.recitationRepository.getRecitations();
            const responseList = recitations.items.map((recitation) => new recitation_resumed_res_1.RecitationResumedRes(recitation));
            res.send(new recitation_list_resumed_res_1.RecitationListResumedRes(responseList));
            next();
        };
        this.getRecitationByIdPublic = async (req, res, next) => {
            return this.handleGetRecitationById(req, res, next, (data) => new recitation_full_res_1.RecitationFullRes(data));
        };
    }
    initialize(httpServer) {
        httpServer.post({
            path: `${this.url}`,
            requestHandler: this.createRecitations.bind(this),
            fileFields: [{ name: 'audios' }, { name: 'images' }],
            customClaims: ['superAdmin'],
        });
        httpServer.get({
            path: `${this.url}`,
            requestHandler: this.getRecitationListPublic.bind(this),
            customClaims: ['user'],
        });
        httpServer.get({
            path: `${this.url}:recitationId`,
            requestHandler: this.getRecitationByIdPublic.bind(this),
            customClaims: ['user'],
        });
        httpServer.get({
            path: `${this.url}/files-path`,
            requestHandler: this.getFilePathPublic.bind(this),
            customClaims: ['user'],
        });
    }
    async handleGetRecitationById(req, res, next, onSuccess) {
        var _a;
        if (!((_a = req.params.recitationId) === null || _a === void 0 ? void 0 : _a.length)) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", "Please, inform a recitationId on the route");
        }
        // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
        // const getRecitationByIdCached = req.cacheOf(
        //   "recitationId_param",
        //   recitationRepository.getRecitationById
        // );
        const recitation = await recitation_repository_1.recitationRepository.getRecitationById(req.params.recitationId);
        if (recitation == null) {
            throw new http_response_error_1.HttpResponseError(404, "NOT_FOUND", "Recitation id " + req.params.recitationId + " not found");
        }
        res.status(200).send(onSuccess(recitation));
        next();
    }
}
exports.RecitationController = RecitationController;
//# sourceMappingURL=recitation-controller.js.map