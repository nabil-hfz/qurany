import { NextFunction, RequestHandler } from 'express';
import { Controller, HttpServer } from "../index";
import { AppConst } from "../../constant/app.const";
import { logEndSuccessRequest, logStartRequest } from '../../utils/logger';
import { statusLables, AppRoutes, AppFirebaseCollections } from '../../firebase/collections';
import { checkIfIsValidCreateRecitationReqBody } from './requests/create-recitation/create-recitation-validation';
import { CreateRecitationReqBody } from './requests/create-recitation/create-recitation-req-body';
import { recitationRepository } from '../../repository/recitation/recitation-repository';
import { RecitationResumedRes } from './responses/recitation-resumed-res';
import { RecitationListResumedRes } from './responses/recitation-list-resumed-res';
import { HttpResponseError } from '../../utils/http-response-error';
import { RecitationFullRes } from './responses/recitation-full-res';
import { IRecitationModel } from '../../models/recitation-model';

export class RecitationController implements Controller {

  url = `${AppConst.AppFunctionVersion1}${AppRoutes.recitationsRoute}`;

  initialize(httpServer: HttpServer): void {
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

  private readonly createRecitations: RequestHandler =
    async (req: any, res, next) => {
      logStartRequest(req, 'RecitationController', 'createRecitations')
      const reqBody: CreateRecitationReqBody = Object.assign({}, req.body);


      checkIfIsValidCreateRecitationReqBody(reqBody);

      const reciterIndex = reqBody.reciterIndex
      const currentFilesPath = statusLables[reciterIndex];
      if (reciterIndex >= statusLables.length || !currentFilesPath) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterIndex"');
      }

      const audios = req.files['audios'] as Express.Multer.File[];
      if (!audios || !audios.length) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "audios"');
      }

      const images = req.files['images'] as Express.Multer.File[];
      if (!images || !images.length) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "images"');
      }


      const result = await recitationRepository
        .createRecitations(reqBody, images, audios)

      logEndSuccessRequest(req, 'RecitationController', 'createRecitations')

      res.status(200).send({
        message: 'Recitations created successfully',
        recitations: result,
      });
      next();
    };

  private readonly getFilePathPublic: RequestHandler = async (req, res, next) => {
    res.status(200).send(
      statusLables
        .map((filePath, index) => {
          return {
            index,
            audiosPath: AppFirebaseCollections.audiosStoragePath + filePath,
            iamgesPath: AppFirebaseCollections.imagesStoragePath + filePath,
          }
        }));
    next();

  };


  private readonly getRecitationListPublic: RequestHandler = async (req, res, next) => {
    const recitations = await recitationRepository.getRecitations();
    const responseList = recitations.items.map(
      (recitation) => new RecitationResumedRes(recitation)
    );
    res.send(new RecitationListResumedRes(responseList));
    next();
  };

  private readonly getRecitationByIdPublic: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    return this.handleGetRecitationById(
      req,
      res,
      next,
      (data) => new RecitationFullRes(data)
    );
  };

  private async handleGetRecitationById(
    req: any,
    res: any,
    next: NextFunction,
    onSuccess: (recatation: IRecitationModel) => any
  ) {
    if (!req.params.recitationId?.length) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, inform a recitationId on the route"
      );
    }

    // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
    // const getRecitationByIdCached = req.cacheOf(
    //   "recitationId_param",
    //   recitationRepository.getRecitationById
    // );
    const recitation = await recitationRepository.getRecitationById(req.params.recitationId);

    if (recitation == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "Recitation id " + req.params.recitationId + " not found"
      );
    }
    res.status(200).send(onSuccess(recitation));
    next();
  }
}


