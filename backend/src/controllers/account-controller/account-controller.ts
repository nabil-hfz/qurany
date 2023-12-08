import { Controller, HttpServer } from "../index";
import { RequestHandler } from "express";
import { CreateAccountReqBody } from "./requests/create-account/create-account-req-body";
import { CreateAccountResBody } from "./responses/create-account-res-body";
import { checkIfIsValidCreateAccountReqBody } from "./requests/create-account/create-account-validation";
import { accountsService } from "../../services/accounts-service";
// import { AppConst } from "../../constant/app.const";

export class AccountController implements Controller {
  accountPath = "/reciter/";
  
  initialize(httpServer: HttpServer): void {
    // const url = `${AppConst.AppFunctionVersion1}${this.accountPath}`;
    // httpServer.post(url, this.createAccount.bind(this));
    this.createAccount.toString();
  }

  private readonly createAccount: RequestHandler = async (req, res, next) => {
    const body: CreateAccountReqBody = Object.assign({}, req.body);

    checkIfIsValidCreateAccountReqBody(body);

    const refreshedUser = await accountsService.createAccount(
      body.role,
      body.name,
      body.email,
      body.password
    );

    res.send(new CreateAccountResBody(refreshedUser));
    next();
  };
}
