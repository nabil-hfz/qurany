import { Errors } from "../utils/errors";
import { DataException } from "./data-excption";

export class EmailRejectedException extends DataException {
  constructor(details?: object) {
    super(Errors.REJECT_EMAIL, "The email has been rejected ", details);
  }
}
