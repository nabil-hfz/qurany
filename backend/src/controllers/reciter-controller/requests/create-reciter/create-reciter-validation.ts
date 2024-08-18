import { CreateReciterReqBody } from "./create-reciter-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateReciterReqBody(body: CreateReciterReqBody) {

  if (!body?.reciterIndex) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "reciterIndex" defined ');
  }

  if (!body?.name?.translations?.en?.length || !body?.name?.translations?.ar?.length) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "name en or ar" defined');
  }

  if (!body?.bio?.translations?.en?.length || !body?.bio?.translations?.ar?.length) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "bio"');
  }
  if (!body?.numberOfKhatmat) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "numberOfKhatmat" defined ');
  }

  if (!body?.recitationTypes) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "recitationTypes" defined ');
  }
  // if (!body?.stockQuantity || body.stockQuantity < 0) {
  //   throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "stockQuantity"');
  // }

  // if (!body?.internalCode?.length) {
  //   throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "internalCode"');
  // }
}
