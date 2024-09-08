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
import { filesRepository } from '../../repository/file/files-repository';
import { AppRoles } from '../../constant/app-roles.const';

export class LibraryController implements Controller {

  url = AppRoutes.libraryRoute;

  initialize(httpServer: HttpServer): void {
    // File entry
    httpServer.post({
      path: this.url,
      requestHandler: this.createFileEntry.bind(this),
      fileFields: [{ name: 'file' }],
      customClaims: [AppRoles.admin],
    });

    httpServer.put({
      path: `${this.url}/increase-views-count/:id`,
      requestHandler: this.increaseViewsCount.bind(this),
      customClaims: [AppRoles.guest],
    });

    httpServer.put({
      path: `${this.url}/increase-downloads-count/:id`,
      requestHandler: this.increaseDownloadsCount.bind(this),
      customClaims: [AppRoles.guest],
    });


    httpServer.get({
      path: this.url,
      requestHandler: this.getFileEntryList.bind(this),
      customClaims: [AppRoles.guest],
    });

    httpServer.get({
      path: `${this.url}/:id`,
      requestHandler: this.getFileEntryById.bind(this),
      customClaims: [AppRoles.guest],
    });

    httpServer.delete({
      path: `${this.url}/:id`,
      requestHandler: this.deleteFileEntryById.bind(this),
      customClaims: [AppRoles.superAdmin],
    });
  }


  private readonly createFileEntry: RequestHandler =
    async (req: any, res, next) => {

      const reqBody: CreateFileEntryReqBody = Object.assign({}, req.body);
      checkIfIsValidCreateFileEntryReqBody(reqBody);

      const file = req.files['file'] as Express.Multer.File[];
      if (!file) {
        throw new HttpResponseError(400, "BAD_REQUEST", 'No file found "file" in the body');
      }
      console.log('file ', file);

      const result = await libraryRepository
        .createFileEntry(reqBody, file[0]);

      res.status(200).send(ResponseModel.toResult(new FileEntryFullRes(result)));
      // next();
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
    // next();
  };

  private readonly getFileEntryById: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = +req.params.id;
    if (!id) {
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
    // next();
  }


  private readonly deleteFileEntryById: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = +req.params.id;
    if (!id) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'id' for file entry is defined " + id
      );
    }
    // libraryRepository.
    const fileEntry = await libraryRepository.getOneById(id);
    if (fileEntry == null || fileEntry.id == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }

    await libraryRepository.getOneById(id);
    const isDeleted = await libraryRepository.delete(fileEntry.id);
    if (!isDeleted) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }

    if (fileEntry.file?.id != null) {
      const fileId = fileEntry.file!.id;
      const isFileDeleted = await filesRepository.delete(fileId);
      if (!isFileDeleted) {
        throw new HttpResponseError(
          404,
          "NOT_FOUND",
          "File could not be deleted with id " + fileId + " not found"
        );
      }
    }
    if (fileEntry.thumbnail?.id != null) {
      const thumbnailId = fileEntry.thumbnail!.id;
      const isThumbnailDeleted = await filesRepository.delete(thumbnailId);
      if (!isThumbnailDeleted) {
        throw new HttpResponseError(
          404,
          "NOT_FOUND",
          "Thumbnail file could not be deleted with id " + thumbnailId + " not found"
        );
      }
    }

    res.status(200).send(ResponseModel.toResult(isDeleted));
    // next();
  }


  private readonly increaseViewsCount: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = +req.params.id;
    if (!id) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'id' for file entry is defined " + id
      );
    }
    const result = await libraryRepository.incrementIntValue(id, "totalViews");
    if (result == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }

    const fileEntry = await libraryRepository.getOneById(id);
    if (fileEntry == null || fileEntry.id == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }

    res.status(200).send(ResponseModel.toResult(fileEntry));
  }


  private readonly increaseDownloadsCount: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = +req.params.id;
    if (!id) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'id' for file entry is defined " + id
      );
    }
    const result = await libraryRepository.incrementIntValue(id, "totalDownloads");
    if (result == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }

    const fileEntry = await libraryRepository.getOneById(id);
    if (fileEntry == null || fileEntry.id == null) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "FileEntry id " + id + " not found"
      );
    }

    res.status(200).send(ResponseModel.toResult(fileEntry));
  }
}


