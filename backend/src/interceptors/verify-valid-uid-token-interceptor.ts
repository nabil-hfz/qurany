import { NextFunction, Request, Response } from "express";
// import * as admin from "-admin";
// import * as assert from "node:assert";
import { ErrorResponseBody } from "../utils/http-response-error";
import { AppJsonWebTokenUtils } from "../utils/json-web-token-utils";

export const verifyValidUidTokenInterceptor = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.log('req.headers["authorization"] ', req.headers["authorization"]);
  const authorizationHeaderValue: string | undefined = (
    req.headers["Authorization"]?.length
      ? req.headers["Authorization"]
      : req.headers["authorization"]
  )?.toString();
  if (!authorizationHeaderValue?.length) {
    req.authenticated = false;
    next();
    return;
  }

  // let finished = false;

  // setTimeout(() => {
  //   if (!finished) {
  //     finished = true;
  //     return res.status(401).send(
  //       new ErrorResponseBody({
  //         status: 401,
  //         code: "UNAUTHORIZED",
  //         description: "Invalid 'Authorization' token (timeout)",
  //       })
  //     );
  //   } return;
  // }, 5500);

  if (authorizationHeaderValue.startsWith("Bearer ")) {
    const AuthToken: string = authorizationHeaderValue.substring("Bearer ".length);

    console.log("AuthToken ", AuthToken);

    const jwtPayload = await AppJsonWebTokenUtils.decodeToken(AuthToken);
    console.log("jwtPayload ", jwtPayload);

    if (jwtPayload) {
      req.authenticated = true;
      req.uid = jwtPayload.userId;
      req.email = jwtPayload.email;
      req.token = AuthToken;
      req.customClaims = jwtPayload.customClaims;
      next();
      return;
    }

    // if (!finished) {
    //   finished = true;
    // }
    return res.status(401).send(
      new ErrorResponseBody({
        status: 401,
        code: "UNAUTHORIZED",
        description: "Invalid 'Authorization' token",
      })
    );

    // admin
    //   .auth()
    //   .verifyIdToken(AuthToken, true)
    //   .then(
    //     async (decoded) => {
    //       if (!finished) {
    //         finished = true;

    //         req.authenticated = true;
    //         req.auth = await admin.auth().getUser(decoded.uid);
    //         req.token = decoded;

    //         // assert(req.auth != null);
    //         // assert(req.token != null);

    //         next();
    //       }
    //     },
    //     (reason) => {
    //       console.error(`Invalid 'Authorization' token: ${reason}`);
    //       if (!finished) {
    //         finished = true;
    //         res.status(401).send(
    //           new ErrorResponseBody({
    //             status: 401,
    //             code: "UNAUTHORIZED",
    //             description: "Invalid 'Authorization' token",
    //           })
    //         );
    //       }
    //     }
    //   );
  } else {
    return res.status(400).send(
      new ErrorResponseBody({
        status: 400,
        code: "BAD_REQUEST",
        description:
          "Invalid 'Authorization' header value, should be: 'Bearer <token>'",
      })
    );
  }
};
