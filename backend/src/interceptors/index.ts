import { Request, Response, NextFunction } from "express";
import { verifyValidUidTokenInterceptor } from "./verify-valid-uid-token-interceptor";
import { instantiateCacheInterceptor } from "./instantiate-cache-interceptor";

export const interceptors: Array<
  (req: Request, res: Response, next: NextFunction) => void
> = [instantiateCacheInterceptor, verifyValidUidTokenInterceptor];
