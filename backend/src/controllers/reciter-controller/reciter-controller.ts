import { Controller, HttpServer } from "../index";
import { RequestHandler } from "express";
import { recitersRepository } from "../../repository/reciter/reciters-repository";
import { HttpResponseError } from "../../utils/http-response-error";
// import { RecitersListResumedRes } from "./responses/reciters-list-resumed-res";
import { ReciterResumedRes } from "./responses/reciter-resumed-res";
import { CreateReciterReqBody } from "./requests/create-reciter/create-reciter-req-body";
import { checkIfIsValidCreateReciterReqBody } from "./requests/create-reciter/create-reciter-validation";
import { ReciterFullRes } from "./responses/reciter-full-res";
import { uploaderService } from "../../services/uploader-service";
import { AppRoutes } from "../../constant/app-routes.const";
import { AppImagesRecitersConst } from "../../constant/app-storage-paths.const";
import { RecitationTypesList } from "../../db/entities/recitation-entity";
import { ResponseModel } from "../../db/response-model";
import { ResponseListModel } from "../../db/entities/response-list-model";

export class ReciterController implements Controller {

  url = AppRoutes.recitersRoute;

  initialize(httpServer: HttpServer): void {

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

  private readonly createReciter: RequestHandler = async (req: any, res, next,) => {
    const bio = JSON.parse(req.body.bio);
    const name = JSON.parse(req.body.name);

    const recitationTypes = JSON.parse(req.body.recitationTypes.toString()) as number[];

    recitationTypes?.every((type) => type == RecitationTypesList.indexOf(type))
    if (recitationTypes) {
      let allFound = recitationTypes!.every((type) => RecitationTypesList.indexOf(type) != -1);
      if (!allFound)
        throw new HttpResponseError(400, "BAD_REQUEST", 'Reciter has one or more unsupported recitation type');
    }

    const reqBody: CreateReciterReqBody = Object.assign({}, { ...req.body, bio, name, recitationTypes });
    checkIfIsValidCreateReciterReqBody(reqBody);


    let imagePath = AppImagesRecitersConst[reqBody.reciterIndex];
    if (!imagePath) throw new HttpResponseError(400, "BAD_REQUEST", 'Reciter Nr Not found.');

    const image = req.files['image'];
    if (!image || !image.length) { res.status(400).send({ message: 'No Image found' }); return; }


    const filesResult = await uploaderService.saveFile(image[0], imagePath);
    const reciter = await recitersRepository.createReciter(reqBody, filesResult);

    res.send(ResponseModel.toResult(new ReciterFullRes(reciter)));
    next();
  }

  private readonly getReciterListPublic: RequestHandler = async (req, res, next) => {
    const pagination = req.pagination;

    const reciters = await recitersRepository.getReciters(pagination);
    const responseList = reciters.items.map(
      (reciter) => new ReciterResumedRes(reciter)
    );
    res.send(ResponseListModel.toResult({
      message: "",
      items: responseList,
    }));
    next();
  };


  private readonly getReciterByIdPublic: RequestHandler = async (req, res, next) => {
    const reciterId = Number(req.params.reciterId);
    if (!reciterId) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, inform a reciterId on the route"
      );
    }
    const reciter = await recitersRepository.getReciterById(reciterId);
    if (!reciter)
      throw new HttpResponseError(400, "BAD_REQUEST", "Please, reciter with this id not found");
    
      res.send(ResponseModel.toResult(new ReciterFullRes(reciter)));
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
