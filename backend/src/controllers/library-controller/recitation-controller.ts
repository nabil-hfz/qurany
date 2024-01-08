import { RequestHandler } from 'express';
import { Controller, HttpServer } from "../index";
import { checkIfIsValidCreateFileEntryReqBody } from './requests/create-file-entry/create-file-entry-validation';
import { CreateFileEntryReqBody } from './requests/create-file-entry/create-file-entry-req-body';
import { HttpResponseError } from '../../utils/http-response-error';
import { AppRoutes } from '../../constant/app-routes.const';
import { AppAudiosConst, AppImagesKhatmeConst } from '../../constant/app-storage-paths.const';
import { ResponseListModel } from '../../repository/response-list-model';
import { ResponseModel } from '../../db/response-model';
import { libraryRepository } from '../../repository/library/library-repository';

export class FileEntryController implements Controller {

  url = AppRoutes.recitationsRoute;

  initialize(httpServer: HttpServer): void {
    httpServer.post({
      path: this.url,
      requestHandler: this.createFileEntrys.bind(this),
      fileFields: [{ name: 'audios' }, { name: 'images' }],
      customClaims: ['superAdmin'],
    });

    httpServer.get({
      path: this.url,
      requestHandler: this.getFileEntryListPublic.bind(this),
      customClaims: ['user'],
    });

    httpServer.get({
      path: `${this.url}-files-path`,
      requestHandler: this.getFilePathPublic.bind(this),
      customClaims: ['user'],
    });

    httpServer.get({
      path: `${this.url}/:recitationId`,
      requestHandler: this.getFileEntryByIdPublic.bind(this),
      customClaims: ['user'],
    });



  }

  private readonly createFileEntrys: RequestHandler =
    async (req: any, res, next) => {
      // logStartRequest(req, 'FileEntryController', 'createFileEntrys')
      const reqBody: CreateFileEntryReqBody = Object.assign({}, req.body);


      checkIfIsValidCreateFileEntryReqBody(reqBody);

      // const reciterIndex = reqBody.reciterIndex
      // const currentFilesPath = AppImagesKhatmeConst[reciterIndex];
      // if (!currentFilesPath) {
      //   throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterIndex"');
      // }

      const audios = req.files['audios'] as Express.Multer.File[];
      if (!audios || !audios.length) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "audios"');
      }

      const images = req.files['images'] as Express.Multer.File[];
      if (!images || !images.length) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "images"');
      }


      const result = await libraryRepository
        .createFileEntrys(reqBody, images, audios)

      // logEndSuccessRequest(req, 'FileEntryController', 'createFileEntrys')

      res.status(200).send(
        ResponseListModel.toResult({
          message: 'FileEntrys created successfully',
          items: result,
        })
      );
      next();
    };

  private readonly getFilePathPublic: RequestHandler = async (req, res, next) => {
    res.status(200).send(
      ResponseModel.toResult({
        audiosPath: { ...AppAudiosConst },
        imagesPath: { ...AppImagesKhatmeConst }
      })
    );
    next();
  };


  private readonly getFileEntryListPublic: RequestHandler = async (req, res, next) => {
    const pagination = req.pagination;
    let reciterId = Number(req.query.reciterId);
    let khatmaId = Number(req.query.khatmaId);

    if (!reciterId && !khatmaId) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'reciterId' or 'khatmaId' was provided"
      );
    }

    const recitations = await libraryRepository
      .getFileEntrys(
        reciterId,
        khatmaId,
        pagination
      );
      
    const responseList = recitations.items.map(
      (recitation) => new FileEntryResumedRes(recitation)
    );
    res.status(200).send(
      ResponseListModel.toResult({
        items: responseList,
      })
    );
    next();
  };

  private readonly getFileEntryByIdPublic: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {

    if (!req.params.recitationId?.length) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, inform a recitationId on the route"
      );
    }

    // If there's a cache: it will use the cache, otherwise: it will wait for the getProductById result and cache it
    // const getFileEntryByIdCached = req.cacheOf(
    //   "recitationId_param",
    //   recitationRepository.getFileEntryById
    // );
    const recitation = await recitationRepository.getFileEntryById(req.params.recitationId);

    if (recitation == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + req.params.recitationId + " not found"
      );
    }
    res.status(200).send(ResponseModel.toResult(new FileEntryFullRes(recitation)));
    next();
  }
}


