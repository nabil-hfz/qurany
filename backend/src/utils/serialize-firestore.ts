import { DocumentReference } from "firebase-admin/firestore";
import { Timestamp, FieldValue } from "firebase-admin/firestore";
// import { logError } from "./logger";

/** Serializes a value to a valid Firestore Document data, including object and its childs and Array and its items */
function isDate(value: any): boolean {
  if (value instanceof Date || value instanceof Timestamp) {
    return true;
  }
  // try {
  //   if (value.toDate() instanceof Date) {
  //     return true;
  //   }
  // } catch (e) {
  //   logError(e);
  //  }
  return false;
}

function serializeFS(value: any): any {
  if (value == null) {
    return null;
  }
  if (
    typeof value == "boolean" ||
    typeof value == "bigint" ||
    typeof value == "string" ||
    typeof value == "symbol" ||
    typeof value == "number" ||
    isDate(value) ||
    value instanceof FieldValue ||
    value instanceof DocumentReference

  ) return value;

  if (Array.isArray(value)) {
    return value.map((v: any) => serializeFS(v));
  }

  const res: any = {};
  for (const key of Object.keys(value)) {
    if(value[key]!= null)
    res[key] = serializeFS(value[key]);
  }
  return res;
}

export { serializeFS };
