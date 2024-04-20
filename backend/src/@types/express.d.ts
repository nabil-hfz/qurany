import { JwtPayload } from 'jsonwebtoken';
import { DecodedIdToken, UserRecord } from "firebase-admin/lib/auth";

export type CacheOfFunction<T, TProducer extends (...args: any[]) => T> = (
  cacheId: string,
  generateCacheIfIsNeeded?: TProducer,
  oldCache?: "use-old-cache" | "override-cache"
) => TProducer;

declare global {
  namespace Express {
    interface Request {
      /** Indicates whether the user is authenticated or not */
      authenticated: boolean;

      /** If authenticated: represents user id.  */
      uid?: number;

      /** If authenticated: represents user email.  */
      email?: string;

      /** If authenticated: Contains token data of JWT. */
      token?: string;

      /** If authenticated: Contains all user's roles. */
      customClaims?: { [key: string]: any };

      /**
       * Caches the result of a function based on the `cacheId` param.
       * Helps to avoid perfoming multiple identical queries to the repository on the same request handler
       *  */
      cacheOf: CacheOfFunction<any, any>;

      /**
       * Invalidate a cache based on the `cacheId` param
       *
       * This will not affect the other requests.
       * */
      invalidateCache: (cacheId: string) => void;
    }
  }
}
