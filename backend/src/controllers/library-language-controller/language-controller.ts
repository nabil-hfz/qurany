import { RequestHandler } from 'express';
import { Controller, HttpServer } from "../index";
import { HttpResponseError } from '../../utils/http-response-error';
import { AppRoutes } from '../../constant/app-routes.const';
import { ResponseListModel } from '../../repository/response-list-model';
import { ResponseModel } from '../../db/response-model';
import { checkIfIsValidCreateLanguagesReqBody } from './requests/create-language/create-language-validation';
import { languageRepository } from '../../repository/library/language-repository';
import { LanguageResumedRes } from './responses/language/language-resumed-res';
import { CreateLanguagesReqBody } from './requests/create-language/create-language-req-body';
import { AppRoles } from '../../constant/app-roles.const';

export class LanguageController implements Controller {

  url = AppRoutes.languageRoute;

  initialize(httpServer: HttpServer): void {

    // Language
    httpServer.post({
      path: this.url,
      requestHandler: this.createLanguages.bind(this),
      customClaims: [AppRoles.admin],
    });

    httpServer.get({
      path: this.url,
      requestHandler: this.getLanguageList.bind(this),
      customClaims: [AppRoles.user],
    });

    httpServer.delete({
      path: `${this.url}/:id`,
      requestHandler: this.deleteLanguageById.bind(this),
      customClaims: [AppRoles.superAdmin],
    });
  }

  private readonly createLanguages: RequestHandler =
    async (req: any, res, next) => {

      const reqBody: CreateLanguagesReqBody = Object.assign({}, req.body);
      checkIfIsValidCreateLanguagesReqBody(reqBody);

      const data = await languageRepository
        .createLanguages(reqBody);

      const list = data.map(
        (entry: any) => new LanguageResumedRes(entry)
      );

      res.status(200).send(
        ResponseListModel.toResult({
          items: list
        })
      );

    };

  private readonly getLanguageList: RequestHandler = async (req, res, next) => {
    const pagination = req.pagination;

    const response = await languageRepository
      .getLanguages(pagination);

    const responseList = response.items.map(
      (entity) => new LanguageResumedRes(entity)
    );

    res.status(200).send(
      ResponseListModel.toResult({
        items: responseList,
      })
    );
  };


  private readonly deleteLanguageById: RequestHandler = async (
    req: any,
    res: any,
    next: any,
  ) => {
    const id = req.params.id;
    if (!id?.length) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        "Please, no 'id' for is defined " + id
      );
    }

    const isDeleted = await languageRepository.delete(id);

    if (!isDeleted) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "Language id " + id + " not found"
      );
    }
    res.status(200).send(ResponseModel.toResult(isDeleted));
  }

}


