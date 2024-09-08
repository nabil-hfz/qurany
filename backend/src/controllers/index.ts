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
type PutParams = {
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
    param: PutParams
  ): void {
    this.express.put(
      param.path,
      this._catchErrorHandler(param.requestHandler, param.customClaims)
    );
  }

  private readonly _catchErrorHandler = (
    requestHandlers: RequestHandler[] | RequestHandler,
    allowedRoles?: AppRoles[]
  ) => {
    return async (req: Request, res: Response, next: NextFunction) => {
      console.log('req.authenticated is ', req.authenticated);
      console.log('req.token is ', req.token);
      console.log('req.customClaims is ', req.customClaims);

      const userRoles = req.customClaims;

      const checkCustomClaim = () => {

        const hasPermission = allowedRoles?.some(role => userRoles?.role >= role);

        if (userRoles?.length && !hasPermission) {
          throw new HttpResponseError(
            403,
            "FORBIDDEN",
            "You do not have sufficent permission to do this action."
          );
        }
      };
      try {
        // checkCustomClaim.toString();
        await checkCustomClaim();
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
          console.error('1- Error happened ', e)
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
        console.error('2- Error happened ', e)
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
