"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReciterController = void 0;
const reciters_repository_1 = require("../../repository/reciter/reciters-repository");
const http_response_error_1 = require("../../utils/http-response-error");
const reciters_list_resumed_res_1 = require("./responses/reciters-list-resumed-res");
const reciter_resumed_res_1 = require("./responses/reciter-resumed-res");
const app_const_1 = require("../../constant/app.const");
const collections_1 = require("../../firebase/collections");
const create_reciter_validation_1 = require("./requests/create-reciter/create-reciter-validation");
const reciter_full_res_1 = require("./responses/reciter-full-res");
const uploader_service_1 = require("../../services/uploader-service");
class ReciterController {
    constructor() {
        this.url = `${app_const_1.AppConst.AppFunctionVersion1}${collections_1.AppRoutes.recitersRoute}`;
        this.createReciter = async (req, res, next) => {
            const bio = JSON.parse(req.body.bio);
            const name = JSON.parse(req.body.name);
            const reqBody = Object.assign({}, Object.assign(Object.assign({}, req.body), { bio, name }));
            (0, create_reciter_validation_1.checkIfIsValidCreateReciterReqBody)(reqBody);
            const image = req.files['image'];
            if (!image || !image.length) {
                res.status(400).send({ message: 'No Image found' });
                return;
            }
            const filesResult = await uploader_service_1.uploaderService.saveFile(image[0], reqBody.imagePath);
            const reciter = await reciters_repository_1.recitersRepository.createReciter(reqBody, filesResult);
            res.send(new reciter_full_res_1.ReciterFullRes(reciter));
            // next();
        };
        this.getReciterListPublic = async (req, res, next) => {
            const reciters = await reciters_repository_1.recitersRepository.getReciters();
            const responseList = reciters.items.map((reciter) => new reciter_resumed_res_1.ReciterResumedRes(reciter));
            res.status(200).send(new reciters_list_resumed_res_1.RecitersListResumedRes(responseList));
        };
        this.getReciterByIdPublic = async (req, res, next) => {
            var _a;
            console.log('Hello baby ', req.params);
            if (!((_a = req.params) === null || _a === void 0 ? void 0 : _a.reciterId)) {
                throw new http_response_error_1.HttpResponseError(400, "BAD_REQUEST", "Please, inform a reciterId on the route");
            }
            const ans = await reciters_repository_1.recitersRepository.getReciterById(req.params.reciterId);
            res.send(new reciter_full_res_1.ReciterFullRes(ans));
            next();
        };
        // private async handleGetReciterById(
        //   req: Request,
        //   res: any,
        //   next: any,
        //   // onSuccess: (product: ReciterModel) => any
        // ) {
        //   return;
        //   // return onSuccess(result!);
        //   // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
        //   const getReciterByIdCached = req.cacheOf(
        //     "reciterId_param",
        //     recitersRepository.getReciterById
        //   );
        //   const reciter = await getReciterByIdCached(req.params.reciterId);
        //   if (reciter == null) {
        //     throw new HttpResponseError(
        //       404,
        //       "NOT_FOUND",
        //       "Reciter ID " + req.params.reciterId + " not found"
        //     );
        //   }
        //   // res.send(onSuccess(reciter));
        //   // next();
        // }
        // private readonly getProductByIdFull: RequestHandler = async (req, res, next,) => {
        //     const getProductByIdCached = req.cacheOf('productId_param', recitersRepository.getProductById);
        //     const product = await getProductByIdCached(req.params['productId']);
        //     if(product == null){
        //         throw new HttpResponseError(404, 'NOT_FOUND', 'Product ID '+req.params['productId'] + ' not found');
        //     }
        //     if (product.storeOwnerUid != req.auth!.uid) {
        //         //Even though the client is a storeOwner, he is an owner of another store, so he can't see full details of this product`
        //         throw new HttpResponseError(403, 'FORBIDDEN', `You aren't the correct storeOwner`);
        //     }
        //     return this.handleGetProductById(req,res, next, (data) => new ProductFullRes(data));
        // }
    }
    initialize(httpServer) {
        httpServer.post({ path: this.url, requestHandler: this.createReciter.bind(this), fileFields: [{ name: 'image' }], customClaims: ['superAdmin'] });
        httpServer.get({ path: this.url, requestHandler: this.getReciterListPublic.bind(this), customClaims: ["user"] });
        httpServer.get({ path: `${this.url}/:reciterId`, requestHandler: this.getReciterByIdPublic.bind(this), customClaims: ["user"] });
        // httpServer.get(url, this.getProductListPublic.bind(this));
        // httpServer.post(urlUploadFiles, this.createNewKhatmaAndRecitation.bind(this));
        // httpServer.get(
        //   "/reciter/:reciterId",
        //   this.getReciterByIdPublic.bind(this),
        //   // ["buyer", "storeOwner"]
        // );
        // httpServer.get ('/product/:productId/full-details', this.getProductByIdFull.bind(this), ['storeOwner']);
    }
}
exports.ReciterController = ReciterController;
//# sourceMappingURL=reciter-controller.js.map