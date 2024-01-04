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

/**
 * @swagger
 * paths:
 *  /khatma:
 *    post:
 *      summary: Create a new Khatma
 *      description: Creates a new Khatma with the given details.
 *      tags: [Khatma]
 *      requestBody:
 *        required: true
 *        content:
 *          application/json:
 *            schema:
 *              type: object
 *              required:
 *                - reciterId
 *                - name
 *                - khatmaType
 *              properties:
 *                reciterId:
 *                  type: number
 *                  description: ID of the reciter.
 *                name:
 *                  type: object
 *                  description: Localized name of the Khatma.
 *                  properties:
 *                    en:
 *                      type: string
 *                      description: English name.
 *                    ar:
 *                      type: string
 *                      description: Arabic name.
 *                khatmaType:
 *                  type: number
 *                  description: Type of the Khatma. for example Hafs or Shoaba recitation.
 *      responses:
 *        '200':
 *          description: Successfully created new Khatma.
 *          content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 items:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/KhatmaFullRes'
 *        '400':
 *          description: Bad request, reciterId, khatmaType or name are missing or invalid.
 *        '404':
 *          description: Khatma not found for the given ID.
 *        '500':
 *          description: Internal server error.
 */
  private readonly createNewKhatma: RequestHandler = async (req: any, res, next) => {

    const reqBody: CreateKhatmaReqBody = Object.assign({}, req.body);
    checkIfIsValidCreateKhatmaReqBody(reqBody);


    const result = await khatmeRepository.createKhatma(reqBody);


    res.status(200).send(
      ResponseModel.toResult(new KhatmaFullRes(result))
    );
    next();
  };

  /**
 * @swagger
 * /khatma:
 *   get:
 *     summary: Retrieve a list of Khatmat
 *     description: Retrieve a paginated list of Khatma with optional filtering by reciter ID.
 *     tags:
 *       - Khatma
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *         required: false
 *         description: Page number of the Khatma list
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *         required: false
 *         description: Number of Khatmat per page
 *       - in: query
 *         name: reciterId
 *         schema:
 *           type: integer
 *         required: false
 *         description: ID of the reciter to filter the Khatmat
 *     responses:
 *       '200':
 *         description: A list of Khatmat.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 items:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/KhatmaResumedRes'
 *       '500':
 *         description: Internal server error.
 */
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
    next();
  };


  /**
 * @swagger
 * /khatma/{khatmaId}:
 *   get:
 *     summary: Retrieve a specific Khatma by ID
 *     description: Retrieve detailed information about a specific Khatma using its ID.
 *     tags:
 *       - Khatma
 *     parameters:
 *       - in: path
 *         name: khatmaId
 *         schema:
 *           type: integer
 *         required: true
 *         description: The ID of the Khatma to retrieve
 *     responses:
 *       '200':
 *         description: Detailed information about the Khatma.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/KhatmaFullRes'
 *       '400':
 *         description: Bad request, khatmaId is missing or invalid.
 *       '404':
 *         description: Khatma not found for the given ID.
 *       '500':
 *         description: Internal server error.
 */
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
    next();
  }
}


