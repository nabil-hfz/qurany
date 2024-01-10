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

export class LanguageController implements Controller {

  url = AppRoutes.languageRoute;

  initialize(httpServer: HttpServer): void {

    // Language
    httpServer.post({
      path: this.url,
      requestHandler: this.createLanguages.bind(this),
      customClaims: ['superAdmin'],
    });

    httpServer.get({
      path: this.url,
      requestHandler: this.getLanguageList.bind(this),
      customClaims: ['user'],
    });

    httpServer.delete({
      path: `${this.url}/:id`,
      requestHandler: this.deleteLanguageById.bind(this),
      customClaims: ['superAdmin'],
    });
  }

  /**
   * @swagger
   * /language:
   *   post:
   *     summary: Create new languages
   *     description: Allows the creation of multiple new languages.
   *     tags: [Language]
   *     requestBody:
   *       required: true
   *       content:
   *         application/json:
   *           schema:
   *             type: object
   *             required:
   *               - languages
   *             properties:
   *               languages:
   *                 type: array
   *                 items:
   *                   type: string
   *                 description: A list of language names to be created.
   *     responses:
   *       '200':
   *         description: A list of created languages.
   *         content:
   *           application/json:
   *             schema:
   *               type: object
   *               properties:
   *                 items:
   *                   type: array
   *                   items:
   *                     $ref: '#/components/schemas/LanguageResumedRes'
   *                   description: A list of created languages
   *
   *       '400':
   *         description: Bad request. Missing or invalid fields in the request.
   */
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

  /**
  * @swagger
  * /language:
  *   get:
  *     summary: Retrieve a list of languages
  *     description: Get a list of all available languages.
  *     tags: [Language]
  *     responses:
  *       '200':
  *         description: A list of languages.
  *         content:
  *           application/json:
  *             schema:
  *               $ref: '#/components/schemas/LanguageResumedRes'
  *       '400':
  *         description: Bad request. Error in retrieving the list.
  */

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


  /**
   * @swagger
   * /language/{id}:
   *   delete:
   *     summary: Delete a language by its ID
   *     description: Deletes a language with the specified ID. Returns true if the deletion was successful.
   *     tags: [Language]
   *     parameters:
   *       - in: path
   *         name: id
   *         required: true
   *         schema:
   *           type: integer
   *         description: The ID of the language to be deleted.
   *     responses:
   *       200:
   *         description: Successfully deleted the language.
   *         content:
   *           application/json:
   *             schema:
   *               $ref: '#/components/schemas/DeleteResponse'
   *       400:
   *         description: Bad request. Invalid or missing ID in the request.
   *         content:
   *           application/json:
   *             schema:
   *               $ref: '#/components/schemas/ErrorResponse'
   *       404:
   *         description: Language not found with the given ID.
   *         content:
   *           application/json:
   *             schema:
   *               $ref: '#/components/schemas/ErrorResponse'
   */
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


