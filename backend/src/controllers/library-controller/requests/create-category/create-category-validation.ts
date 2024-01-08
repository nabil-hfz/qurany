import { CreateCategoryReqBody } from "./create-category-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateRecitationReqBody(body: CreateCategoryReqBody[]) {

  if (!body || body.length <= 0) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "no Name{en, ar}" is defined');
  }

  if (!body.every((item) => { item.ar && item.en })) {
    const result = body.find((item) => { !item.ar || !item.en });
    throw new HttpResponseError(400, "BAD_REQUEST", 'One of the list item does not contain both ar and en ' + result);
  }
}
