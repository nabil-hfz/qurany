import { CreateKhatmaReqBody } from "./create-khatma-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateKhatmaReqBody(body: CreateKhatmaReqBody) {
  // if (!body?.khatmaId.length) {
  //   throw new HttpResponseError(400, "BAD_REQUEST", 'No "khatmaId" defined');
  // }

  if (!body?.reciterId) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "reciterId" defined');
  }


  if (!body?.name) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "name" defined');
  }

  if (!body?.khatmaType) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "type" defined');
  }

}
