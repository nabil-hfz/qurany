import { Controller, HttpServer } from "../index";
import { RequestHandler } from "express";
import { CreateAccountReqBody } from "./requests/create-account/create-account-req-body";
import { UserAccountResBody } from "./responses/user-account-res-body";
import { checkIfIsValidCreateAccountReqBody } from "./requests/create-account/create-account-validation";
import { AppRoutes } from "../../constant/app-routes.const";
import { AppRoles } from "../../constant/app-roles.const";
import { accountsRepository } from "../../repository/account/account-repository";
import { CreateAccountResBody } from "./responses/create-account-res-body";
import { LoginAccountReqBody } from "./requests/login-account/login-account-req-body";
import { AppJsonWebTokenUtils } from "../../utils/json-web-token-utils";

export class AccountController implements Controller {
  url = AppRoutes.accountRoute;

  initialize(httpServer: HttpServer): void {

    httpServer.post({
      path: `${this.url}/register`,
      requestHandler: this.register.bind(this),
      customClaims: [AppRoles.superAdmin],
    });

    httpServer.post({
      path: `${this.url}/login`,
      requestHandler: this.logIn.bind(this),
    });

  }

  private readonly register: RequestHandler = async (req: any, res, next) => {
    const body: CreateAccountReqBody = Object.assign({}, req.body);

    checkIfIsValidCreateAccountReqBody(body);

    const image = req.files?.['images'] as Express.Multer.File[] | undefined;

    const refreshedUser = await accountsRepository.createUser(
      body,
      image && image.length > 0 ? image[0] : undefined,
    );

    res.send(new CreateAccountResBody(refreshedUser));
  };


  private readonly logIn: RequestHandler = async (req, res, next) => {
    const body: LoginAccountReqBody = Object.assign({}, req.body);

    const refreshedUser = await accountsRepository.login(
      body.email,
      body.password
    );

    const token = await AppJsonWebTokenUtils.generateToken(
      refreshedUser.id,
      refreshedUser.email!,
      refreshedUser.customClaims!
    );

    res.send(new UserAccountResBody(refreshedUser, token));
    // next();
  };
}
