"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.KhatmaController = void 0;
const logger_1 = require("../../utils/logger");
const app_const_1 = require("../../constant/app.const");
const logger_2 = require("../../utils/logger");
const collections_1 = require("../../firebase/collections");
const create_khatma_validation_1 = require("./requests/create-khatma/create-khatma-validation");
const khatme_repository_1 = require("../../repository/khatma/khatme-repository");
const http_response_error_1 = require("../../utils/http-response-error");
const khatma_full_res_1 = require("./responses/khatma-full-res");
const khatma_resumed_res_1 = require("./responses/khatma-resumed-res");
const khatma_list_resumed_res_1 = require("./responses/khatma-list-resumed-res");
class KhatmaController {
    constructor() {
        this.url = `${app_const_1.AppConst.AppFunctionVersion1}${collections_1.AppRoutes.khatmeRoute}`;
        this.createNewKhatma = async (req, res, next) => {
            (0, logger_2.logStartRequest)(req, 'KhatmaController', 'createNewKhatma');
            const reqBody = Object.assign({}, req.body);
            (0, create_khatma_validation_1.checkIfIsValidCreateKhatmaReqBody)(reqBody);
            // const reciterId = reqBody.reciterId as string | null;
            // const khatmaName = reqBody.name;
            // const type = reqBody.type;
            (0, logger_1.logInfo)('CreateKhatmaReqBody is: ' + reqBody);
            const newKhatma = await khatme_repository_1.khatmeRepository.createKhatma(reqBody);
            (0, logger_2.logEndSuccessRequest)(req, 'KhatmaController', 'createNewKhatma');
            res.status(200).send({
                message: 'Khatma created successfully',
                khatmaId: newKhatma,
            });
            next();
        };
        this.getKhatmaListPublic = async (req, res, next) => {
            const data = await khatme_repository_1.khatmeRepository.getKhatme();
            const responseList = data.items.map((khatma) => new khatma_resumed_res_1.KhatmaResumedRes(khatma));
            res.send(new khatma_list_resumed_res_1.KhatmeListResumedRes(responseList));
            next();
        };
        this.getKhatmaByIdPublic = async (req, res, next) => {
            return this.handleGetKhatmaById(req, res, next, (data) => new khatma_full_res_1.KhatmaFullRes(data));
        };
    }
    initialize(httpServer) {
        httpServer.post({
            path: this.url,
            requestHandler: this.createNewKhatma.bind(this),
            customClaims: ['superAdmin'],
        });
        httpServer.get({
            path: `${this.url}`,
            requestHandler: this.getKhatmaListPublic.bind(this),
            customClaims: ['user'],
        });
        httpServer.get({
            path: `${this.url}/:khatmaId`,
            requestHandler: this.getKhatmaByIdPublic.bind(this),
            customClaims: ['user'],
        });
    }
    async handleGetKhatmaById(req, res, next, onSuccess) {
        var _a;
        if (!((_a = req.params.khatmaId) === null || _a === void 0 ? void 0 : _a.length)) {
            throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", "Please, inform a khatmaId on the route");
        }
        // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
        // const getKhatmaByIdCached = req.cacheOf(
        //   "khatmaId_param",
        //   khatmeRepository.getKhatmaById
        // );
        const khatma = await khatme_repository_1.khatmeRepository.getKhatmaById(req.params.khatmaId);
        if (khatma == null) {
            throw new http_response_error_1.HttpResponseError(404, "NOT_FOUND", "Khatma ID " + req.params.khatmaId + " not found");
        }
        res.send(onSuccess(khatma));
        next();
    }
}
exports.KhatmaController = KhatmaController;
//# sourceMappingURL=khatma-controller.js.map