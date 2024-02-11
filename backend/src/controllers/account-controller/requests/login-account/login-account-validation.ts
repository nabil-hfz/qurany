import { HttpResponseError } from "../../../../utils/http-response-error";
import { validateEmail } from "../../../../utils/validators";
import { LoginAccountReqBody } from "./login-account-req-body";

export function checkIfIsValidCreateAccountReqBody(body: LoginAccountReqBody) {


  if (!validateEmail(body?.email)) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "email"');
  }

  if (!body?.password?.length || body.password.length < 8) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "password"');
  }
}
