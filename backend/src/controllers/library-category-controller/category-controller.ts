import { RequestHandler } from 'express';
import { Controller, HttpServer } from "../index";
import { HttpResponseError } from '../../utils/http-response-error';
import { AppRoutes } from '../../constant/app-routes.const';
import { ResponseListModel } from '../../repository/response-list-model';
import { ResponseModel } from '../../db/response-model';
import { checkIfIsValidCreateCategoriesReqBody } from './requests/create-category/create-category-validation';
import { CreateCategoriesReqBody } from './requests/create-category/create-category-req-body';
import { categoryRepository } from '../../repository/library/category-repository';
import { CategoryResumedRes } from './responses/category/category-resumed-res';

export class CategoryController implements Controller {

  url = AppRoutes.categoryRoute;

  initialize(httpServer: HttpServer): void {
    // Categories
    httpServer.post({
      path: this.url,
      requestHandler: this.createCategories.bind(this),
      customClaims: ['superAdmin'],
    });

    httpServer.get({
      path: this.url,
      requestHandler: this.getCategoriesList.bind(this),
      customClaims: ['user'],
    });

    httpServer.delete({
      path: `${this.url}/:id`,
      requestHandler: this.deleteCategoryById.bind(this),
      customClaims: ['superAdmin'],
    });

  }

  private readonly createCategories: RequestHandler =
    async (req: any, res, next) => {



      const reqBody: CreateCategoriesReqBody = Object.assign({}, req.body);
      checkIfIsValidCreateCategoriesReqBody(reqBody);



      const data = await categoryRepository
        .createCategories(reqBody);

      const list = data.map(
        (entry: any) => new CategoryResumedRes(entry)
      );

      res.status(200).send(
        ResponseListModel.toResult({
          items: list
        })
      );
    };


  private readonly getCategoriesList: RequestHandler = async (req, res, next) => {
    const pagination = req.pagination;

    const response = await categoryRepository
      .getCategories(pagination);

    const responseList = response.items.map(
      (entity) => new CategoryResumedRes(entity)
    );
    res.status(200).send(
      ResponseListModel.toResult({
        items: responseList,
      })
    );
    // next();
  };

  private readonly deleteCategoryById: RequestHandler = async (
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

    const resource = await categoryRepository.delete(id);

    if (!resource) {
      throw new HttpResponseError(
        404,
        "NOT_FOUND",
        "Category id " + id + " not found"
      );
    }
    res.status(200).send(ResponseModel.toResult(resource));
    // next();
  }

}


