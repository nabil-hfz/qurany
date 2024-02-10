import { Controller, HttpServer } from "../index";
import { RequestHandler } from "express";
import { CreateAccountReqBody } from "./requests/create-account/create-account-req-body";
import { CreateAccountResBody } from "./responses/create-account-res-body";
import { checkIfIsValidCreateAccountReqBody } from "./requests/create-account/create-account-validation";
import { accountsService } from "../../services/accounts-service";
import { AppRoutes } from "../../constant/app-routes.const";
import { AppRoles } from "../../constant/app-roles.const";

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

  private readonly register: RequestHandler = async (req, res, next) => {
    const body: CreateAccountReqBody = Object.assign({}, req.body);

    checkIfIsValidCreateAccountReqBody(body);

    const refreshedUser = await accountsService.createAccount(
      body.role,
      body.name,
      body.email,
      body.password
    );

    res.send(new CreateAccountResBody(refreshedUser));
  };


  private readonly logIn: RequestHandler = async (req, res, next) => {
    const body: CreateAccountReqBody = Object.assign({}, req.body);

    checkIfIsValidCreateAccountReqBody(body);

    const refreshedUser = await accountsService.createAccount(
      body.role,
      body.name,
      body.email,
      body.password
    );

    res.send(new CreateAccountResBody(refreshedUser));
    // next();
  };
}
