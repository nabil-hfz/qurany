import { CreateFileEntryReqBody } from "./create-file-entry-req-body";
import { HttpResponseError } from "../../../../utils/http-response-error";

export function checkIfIsValidCreateFileEntryReqBody(body: CreateFileEntryReqBody) {

  if (!body?.name) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "name" defined');
  }


  if (!body?.languageId) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "languageId" defined');
  }

  if (!body?.categoryIds || body?.categoryIds.length == 0) {
    throw new HttpResponseError(400, "BAD_REQUEST", 'No "categoryIds" defined');
  }
}
