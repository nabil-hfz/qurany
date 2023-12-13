"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AccountController = void 0;
const create_account_res_body_1 = require("./responses/create-account-res-body");
const create_account_validation_1 = require("./requests/create-account/create-account-validation");
const accounts_service_1 = require("../../services/accounts-service");
// import { AppConst } from "../../constant/app.const";
class AccountController {
    constructor() {
        this.accountPath = "/reciter/";
        this.createAccount = async (req, res, next) => {
            const body = Object.assign({}, req.body);
            (0, create_account_validation_1.checkIfIsValidCreateAccountReqBody)(body);
            const refreshedUser = await accounts_service_1.accountsService.createAccount(body.role, body.name, body.email, body.password);
            res.send(new create_account_res_body_1.CreateAccountResBody(refreshedUser));
            next();
        };
    }
    initialize(httpServer) {
        // const url = `${AppConst.AppFunctionVersion1}${this.accountPath}`;
        // httpServer.post(url, this.createAccount.bind(this));
        this.createAccount.toString();
    }
}
exports.AccountController = AccountController;
//# sourceMappingURL=account-controller.js.map