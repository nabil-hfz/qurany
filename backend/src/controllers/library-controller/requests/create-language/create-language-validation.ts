import { CreateLanguageReqBody } from "./create-language-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateRecitationReqBody(body: CreateLanguageReqBody[]) {

  if (!body || body.length <= 0) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "no Name{en, ar}" is defined');
  }

  if (!body.every((item) => { item.name })) {
    let index = null;
    const result = body.find((item) => { !item.name });
    if (result) { index = body.indexOf(result); }
    throw new HttpResponseError(400, "BAD_REQUEST", `List item at ${index} does not contain name vlaue ` + result);
  }
}
