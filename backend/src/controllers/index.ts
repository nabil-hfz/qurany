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

const upload = multer();

type PostParams = {
  path: string;
  requestHandler: RequestHandler[] | RequestHandler;
  fileFields?: any[];
  customClaims?: string[];
};

type GetParams = {
  path: string;
  requestHandler: RequestHandler[] | RequestHandler;
  customClaims?: string[];
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
    path: string,
    requestHandler: RequestHandler,
    customClaims?: string[]
  ): void {
    this.express.delete(
      path,
      this._catchErrorHandler(requestHandler, customClaims)
    );
  }

  put(
    path: string,
    requestHandler: RequestHandler,
    customClaims?: string[]
  ): void {
    this.express.put(
      path,
      this._catchErrorHandler(requestHandler, customClaims)
    );
  }

  private readonly _catchErrorHandler = (
    requestHandlers: RequestHandler[] | RequestHandler,
    customClaims?: string[]
  ) => {
    return async (req: Request, res: Response, next: NextFunction) => {
      const checkCustomClaim = () => {
        if (customClaims?.length) {
          // assert(req.authenticated != null);
          // assert(req.auth != null);

          if (!req.authenticated) {
            throw new HttpResponseError(
              403,
              "FORBIDDEN",
              "You should be authenticated on a Firebase Auth account that have this/these custom claims: " +
              customClaims
            );
          }
          for (const claim of customClaims) {
            if ((req.auth!.customClaims ?? {})[claim]) {
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
        checkCustomClaim.toString();
        // checkCustomClaim();
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
        const userInfo = !req.auth?.uid?.length ? "" : ` uid: ${req.auth.uid}`;

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
        next();
      }
    };
  };
}
