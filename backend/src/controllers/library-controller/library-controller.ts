import { RequestHandler } from 'express';
import { Controller, HttpServer } from "../index";
import { checkIfIsValidCreateFileEntryReqBody } from './requests/create-file-entry/create-file-entry-validation';
import { CreateFileEntryReqBody } from './requests/create-file-entry/create-file-entry-req-body';
import { HttpResponseError } from '../../utils/http-response-error';
import { AppRoutes } from '../../constant/app-routes.const';
import { ResponseListModel } from '../../repository/response-list-model';
import { ResponseModel } from '../../db/response-model';
import { libraryRepository } from '../../repository/library/library-repository';
import { FileEntryFullRes } from './responses/file-entry/file-entry-full-res';
import { FileEntryResumedRes } from './responses/file-entry/file-entry-resumed-res';

export class LibraryController implements Controller {

  url = AppRoutes.libraryRoute;

  initialize(httpServer: HttpServer): void {
    // File entry
    httpServer.post({
      path: this.url,
      requestHandler: this.createFileEntrys.bind(this),
      fileFields: [{ name: 'file' }],
      customClaims: ['superAdmin'],
    });

    httpServer.get({
      path: this.url,
      requestHandler: this.getFileEntryList.bind(this),
      customClaims: ['user'],
    });

    httpServer.get({
      path: `${this.url}/:id`,
      requestHandler: this.getFileEntryById.bind(this),
      customClaims: ['user'],
    });

    httpServer.delete({
      path: `${this.url}/:id`,
      requestHandler: this.deleteFileEntryById.bind(this),
      customClaims: ['superAdmin'],
    });
  }


  private readonly createFileEntrys: RequestHandler =
    async (req: any, res, next) => {

      const reqBody: CreateFileEntryReqBody = Object.assign({}, req.body);
      checkIfIsValidCreateFileEntryReqBody(reqBody);

      const file = req.files['file'] as Express.Multer.File[];
      if (!file) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No file found "file" in the body');
      }

      const result = await libraryRepository
        .createFileEntry(reqBody, file[0]);

      res.status(200).send(ResponseModel.toResult(new FileEntryFullRes(result)));
      next();
    };


  private readonly getFileEntryList: RequestHandler = async (req, res, next) => {
    const pagination = req.pagination;
    let languageId = Number(req.query.languageId);
    let name = req.query.name?.toString();
    let categoryIds: number[] = [];

    if (req.query.categoryIds instanceof Array) {
      req.query.categoryIds?.forEach((element: any) => {
        let id = Number(element);
        categoryIds.push(id);
      });;
    }


    const response = await libraryRepository
      .getFileEntrys(
        languageId,
        categoryIds,
        name,
        pagination,
      );

    const responseList = response.items.map(
      (entity) => new FileEntryResumedRes(entity)
    );
    res.status(200).send(
      ResponseListModel.toResult({
        items: responseList,
      })
    );
    next();
  };

  private readonly getFileEntryById: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = req.params.id;
    if (!id?.length) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'id' for file entry is defined " + id
      );
    }

    const resource = await libraryRepository.getFileEntryById(id);

    if (resource == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }
    res.status(200).send(ResponseModel.toResult(new FileEntryFullRes(resource)));
    next();
  }


  private readonly deleteFileEntryById: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = req.params.id;
    if (!id?.length) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'id' for file entry is defined " + id
      );
    }

    const isDeleted = await libraryRepository.delete(id);

    if (isDeleted == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }
    res.status(200).send(ResponseModel.toResult(isDeleted));
    next();
  }

}


