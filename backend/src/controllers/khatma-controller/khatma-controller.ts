import { Controller, HttpServer } from "../index";
import { RequestHandler } from "express";
import { CreateKhatmaReqBody } from './requests/create-khatma/create-khatma-req-body';
import { checkIfIsValidCreateKhatmaReqBody } from './requests/create-khatma/create-khatma-validation';
import { khatmeRepository } from '../../repository/khatma/khatme-repository';
import { HttpResponseError } from "../../utils/http-response-error";
import { KhatmaFullRes } from "./responses/khatma-full-res";
import { KhatmaResumedRes } from "./responses/khatma-resumed-res";
import { AppRoutes } from "../../constant/app-routes.const";
import { ResponseListModel } from "../../repository/response-list-model";
import { ResponseModel } from "../../db/response-model";

export class KhatmaController implements Controller {

  url = AppRoutes.khatmeRoute;

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

    const reqBody: CreateKhatmaReqBody = Object.assign({}, req.body);
    checkIfIsValidCreateKhatmaReqBody(reqBody);


    const result = await khatmeRepository.createKhatma(reqBody);


    res.status(200).send(
      ResponseModel.toResult(new KhatmaFullRes(result))
    );
    // next();
  };

  private readonly getKhatmaListPublic: RequestHandler = async (req, res, next) => {
    const pagination = req.pagination;
    let reciterId = Number(req.query.reciterId);

    const data = await khatmeRepository.getKhatme(reciterId, pagination);
    const responseList = data.items.map(
      (khatma) => new KhatmaResumedRes(khatma)
    );
    res.status(200).send(
      ResponseListModel.toResult({
        items: responseList
      })
    );
    // next();
  };



  private readonly getKhatmaByIdPublic: RequestHandler = async (req, res, next) => {

    const khatmaId = Number(req.params.khatmaId);
    if (!khatmaId) {
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
    const khatma = await khatmeRepository.getKhatmaById(khatmaId);

    if (khatma == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "Khatma ID " + req.params.khatmaId + " not found"
      );
    }

    res.send(ResponseModel.toResult(new KhatmaFullRes(khatma)));
    // next();
  }
}


