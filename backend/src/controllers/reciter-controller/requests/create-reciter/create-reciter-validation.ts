import { CreateReciterReqBody } from "./create-reciter-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateReciterReqBody(body: CreateReciterReqBody) {

  if (!body?.imagePath)  {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "imagePath" defined ');
  }
  if (!body?.name.en.length || !body?.name.ar.length)  {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "name en or ar" defined');
  }

  if (!body?.bio.en.length || !body?.bio.ar.length) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "bio"');
  }

  // if (!body?.stockQuantity || body.stockQuantity < 0) {
  //   throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "stockQuantity"');
  // }

  // if (!body?.internalCode?.length) {
  //   throw new HttpResponseError(400, "BAD_REQUEST", 'Invalid "internalCode"');
  // }
}
