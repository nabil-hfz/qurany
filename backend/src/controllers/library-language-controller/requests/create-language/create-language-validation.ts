import { CreateLanguagesReqBody } from "./create-language-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateLanguagesReqBody(body: CreateLanguagesReqBody) {

  if (!body.languages || body.languages.length <= 0) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No lanuages list is defined');
  }

  if (!body.languages.every((item) => item)) {
    let index = null;
    const result = body.languages.find((item) => { !item });
    if (result) { index = body.languages.indexOf(result); }
    throw new HttpResponseError(400, "BAD_REQUEST", `List item at ${index} does not contain name vlaue ` + result);
  }
}
