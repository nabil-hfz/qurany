import { Controller, HttpServer } from "../index";
import { Request, RequestHandler } from "express";
import { recitersRepository } from "../../repository/reciter/reciters-repository";
import { HttpResponseError } from "../../utils/http-response-error";
import { RecitersListResumedRes } from "./responses/reciters-list-resumed-res";
import { ReciterResumedRes } from "./responses/reciter-resumed-res";
import { AppConst } from "../../constant/app.const";
import { AppRoutes } from "../../firebase/collections";
import { CreateReciterReqBody } from "./requests/create-reciter/create-reciter-req-body";
import { checkIfIsValidCreateReciterReqBody } from "./requests/create-reciter/create-reciter-validation";
import { ReciterFullRes } from "./responses/reciter-full-res";
import { uploaderService } from "../../services/uploader-service";

export class ReciterController implements Controller {

  url = `${AppConst.AppFunctionVersion1}${AppRoutes.recitersRoute}`;

  initialize(httpServer: HttpServer): void {

    httpServer.post({ path: this.url, requestHandler: this.createReciter.bind(this), fileFields: [{ name: 'image' }], customClaims: ['superAdmin'] });
    httpServer.get({ path: this.url, requestHandler: this.getReciterListPublic.bind(this), customClaims: ["user"] });
    httpServer.get({ path: `${this.url}:reciterId`, requestHandler: this.getReciterByIdPublic.bind(this), customClaims: ["user"] });

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
    const reqBody: CreateReciterReqBody = Object.assign({}, { ...req.body, bio, name });
    checkIfIsValidCreateReciterReqBody(reqBody);

    const image = req.files['image'];
    if (!image || !image.length) { res.status(400).send({ message: 'No Image found' }); return; }

    const filesResult = await uploaderService.saveFile(image[0], reqBody.imagePath);
    const reciter = await recitersRepository.createReciter(reqBody, filesResult);
    res.send(new ReciterFullRes(reciter));
    // next();
  }

  private readonly getReciterListPublic: RequestHandler = async (req, res, next) => {

    const reciters = await recitersRepository.getReciters();
    const responseList = reciters.map(
      (reciter) => new ReciterResumedRes(reciter)
    );
    res.status(200).send(new RecitersListResumedRes(responseList));
  };


  private readonly getReciterByIdPublic: RequestHandler = async (req, res, next) => {
    return this.handleGetReciterById(
      req,
      res,
      next,
      // (data) => new ReciterFullRes(data)
    );
  };

  private async handleGetReciterById(
    req: Request,
    res: any,
    next: any,
    // onSuccess: (product: ReciterModel) => any
  ) {
    // console.log('Hello baby ', req.params);
    if (!req.params?.reciterId) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, inform a reciterId on the route"
      );
    }
    const ans = await recitersRepository.getReciterById(req.params.reciterId);
    res.send(new ReciterFullRes(ans!));
    return;
    // return onSuccess(result!);
    // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
    const getReciterByIdCached = req.cacheOf(
      "reciterId_param",
      recitersRepository.getReciterById
    );
    const reciter = await getReciterByIdCached(req.params.reciterId);

    if (reciter == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "Reciter ID " + req.params.reciterId + " not found"
      );
    }
    // res.send(onSuccess(reciter));
    // next();
  }

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
