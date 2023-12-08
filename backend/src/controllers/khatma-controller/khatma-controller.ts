import { Controller, HttpServer } from "../index";
import { NextFunction, Request, RequestHandler } from "express";
import { logInfo } from "../../utils/logger";



import { AppConst } from "../../constant/app.const";
import { logEndSuccessRequest, logStartRequest } from '../../utils/logger';
import { AppRoutes } from '../../firebase/collections';
import { CreateKhatmaReqBody } from './requests/create-khatma/create-khatma-req-body';
import { checkIfIsValidCreateKhatmaReqBody } from './requests/create-khatma/create-khatma-validation';
import { khatmeRepository } from '../../repository/khatma/khatme-repository';
import { HttpResponseError } from "../../utils/http-response-error";
import { KhatmaModel } from "../../models/khatma-model";
import { KhatmaFullRes } from "./responses/khatma-full-res";
import { KhatmaResumedRes } from "./responses/khatma-resumed-res";
import { KhatmeListResumedRes } from "./responses/khatma-list-resumed-res";

export class KhatmaController implements Controller {

  url = `${AppConst.AppFunctionVersion1}${AppRoutes.khatmeRoute}`;

  initialize(httpServer: HttpServer): void {
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

  private readonly createNewKhatma: RequestHandler = async (req: any, res, next) => {
    logStartRequest(req, 'KhatmaController', 'createNewKhatma')

    const reqBody: CreateKhatmaReqBody = Object.assign({}, req.body);
    checkIfIsValidCreateKhatmaReqBody(reqBody);


    // const reciterId = reqBody.reciterId as string | null;
    // const khatmaName = reqBody.name;
    // const type = reqBody.type;

    logInfo('CreateKhatmaReqBody is: ' + reqBody);

    const newKhatma = await khatmeRepository.createKhatma(reqBody);


    logEndSuccessRequest(req, 'KhatmaController', 'createNewKhatma')
    res.status(200).send({
      message: 'Khatma created successfully',
      khatmaId: newKhatma,
    });
    next();
  };

  private readonly getKhatmaListPublic: RequestHandler = async (req, res, next) => {
    const reciters = await khatmeRepository.getKhatme();
    const responseList = reciters.map(
      (reciter) => new KhatmaResumedRes(reciter, reciter?.id?.id ?? '')
    );
    res.send(new KhatmeListResumedRes(responseList));
    next();
  };

  private readonly getKhatmaByIdPublic: RequestHandler = async (req, res, next) => {
    return this.handleGetKhatmaById(
      req,
      res,
      next,
      (data) => new KhatmaFullRes(data)
    );
  };

  private async handleGetKhatmaById(
    req: Request,
    res: any,
    next: NextFunction,
    onSuccess: (product: KhatmaModel) => any
  ) {
    if (!req.params.khatmaId?.length) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, inform a khatmaId on the route"
      );
    }

    // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
    // const getKhatmaByIdCached = req.cacheOf(
    //   "khatmaId_param",
    //   khatmeRepository.getKhatmaById
    // );
    const khatma = await khatmeRepository.getKhatmaById(req.params.khatmaId);

    if (khatma == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "Khatma ID " + req.params.khatmaId + " not found"
      );
    }
    res.send(onSuccess(khatma));
    next();
  }
}


