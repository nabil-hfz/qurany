import { CreateRecitationReqBody } from "./create-recitation-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateRecitationReqBody(body: CreateRecitationReqBody) {
  
  if (!body?.khatmaId) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "khatmaId" defined');
  }

}
