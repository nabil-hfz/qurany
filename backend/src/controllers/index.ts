import {
  Express,
  NextFunction,
  Request,
  RequestHandler,
  Response,
} from "express";
import {
  ErrorResponseBody,
  HttpResponseError,
} from "../utils/http-response-error";
import { logWarn } from "../utils/logger";
import * as multer from 'multer';
import { paginationMiddleware } from "../middlewares/pagination.middleware";
import { AppRoles } from "../constant/app-roles.const";

const upload = multer();

type PostParams = {
  path: string;
  requestHandler: RequestHandler[] | RequestHandler;
  fileFields?: any[];
  customClaims?: AppRoles[];
};

type GetParams = {
  path: string;
  requestHandler: RequestHandler[] | RequestHandler;
  customClaims?: AppRoles[];
};

export interface Controller {
  initialize(httpServer: HttpServer): void;
}

export class HttpServer {
  constructor(public readonly express: Express) { }

  get(params: GetParams): void {
    const handlers = Array.isArray(params.requestHandler)
      ? params.requestHandler
      : [params.requestHandler];

    this.express.get(
      params.path,
      [paginationMiddleware, ...handlers].map(handler => this._catchErrorHandler(handler, params.customClaims))
    );
  }

  post(param: PostParams): void {
    if (param.fileFields && param.fileFields.length > 0) {
      this.express.post(
        param.path,
        upload.fields(param.fileFields),
        this._catchErrorHandler(param.requestHandler, param.customClaims)
      );
    }
    else {
      this.express.post(
        param.path,
        this._catchErrorHandler(param.requestHandler, param.customClaims)
      );
    }
  }

  delete(
    param: GetParams,
  ): void {
    this.express.delete(
      param.path,
      this._catchErrorHandler(param.requestHandler, param.customClaims)
    );
  }

  put(
    path: string,
    requestHandler: RequestHandler,
    customClaims?: AppRoles[]
  ): void {
    this.express.put(
      path,
      this._catchErrorHandler(requestHandler, customClaims)
    );
  }

  private readonly _catchErrorHandler = (
    requestHandlers: RequestHandler[] | RequestHandler,
    customClaims?: AppRoles[]
  ) => {
    return async (req: Request, res: Response, next: NextFunction) => {
      console.log('req.authenticated is ', req.authenticated);
      console.log('req.token is ', req.token);
      console.log('req.customClaims is ', req.customClaims);
      const checkCustomClaim = () => {

        let result = customClaims?.filter(claim => claim < AppRoles.guest);
        console.log('result is ', result);

        if (customClaims?.length && result?.length) {
          // assert(req.authenticated != null);
          // assert(req.auth != null);

          if (!req.authenticated) {
            throw new HttpResponseError(
              403,
              "FORBIDDEN",
              "You should be authenticated on a Kawtharuna Auth account that have this/these custom claims: " +
              customClaims.map(claim => AppRoles[claim])
            );
          }
          for (const claim of customClaims) {
            if ((req!.customClaims ?? {})[claim]) {
              return;
            }
          }
          throw new HttpResponseError(
            403,
            "FORBIDDEN",
            `Only ${customClaims.toString().replace(/,/g, ", ")} can access`
          );
        }
      };
      try {
        // checkCustomClaim.toString();
        checkCustomClaim();
        // noinspection ES6RedundantAwait
        // Handle both array and single request handler
        if (Array.isArray(requestHandlers)) {
          for (const handler of requestHandlers) {
            await handler(req, res, next);
          }
        } else {
          await requestHandlers(req, res, next);
        }
      } catch (e: any) {
        const userInfo = !req?.uid ? "" : ` uid: ${req?.uid}`;

        if (e instanceof HttpResponseError) {
          logWarn(
            `[${req.method.toUpperCase()}] ${req.path}${userInfo} - ${e.internalLog
            }`
          );
          res.statusCode = e.status;
          res.send(
            new ErrorResponseBody({
              status: e.status,
              code: e.code,
              description: e.description,
            })
          );
          // next();
          return;
        }
        console.error('Error happened ', e)
        // logError(`[${req.method.toUpperCase()}] ${req.path}${userInfo}`);
        // logError(e.stack);
        // logError.toString();
        res.statusCode = 500;
        res.send(
          new ErrorResponseBody({
            status: 500,
            code: "INTERNAL_ERROR",
            description: "An internal error occurred, please contact support " + e,
          })
        );
        return;
        // next();
      }
    };
  };
}
