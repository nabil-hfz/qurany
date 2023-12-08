import { DocumentReference, Timestamp } from "../firebase/firebase-data-classes";
import { Nullable } from "../utils/types";

// type Params = {
//   createdAt?: Timestamp;
//   id?: Nullable<DocumentReference>;
// };

export abstract class BaseModel {
  constructor(
    readonly createdAt?: Timestamp | null,
    readonly id?: Nullable<DocumentReference>,
  ) { }

  // getIdPath(): { id?: string, path?: string } | null {
  //   if (this.params?.id !== null) {
  //     return {
  //       id: this.params?.id?.id,
  //       path: this.params?.id?.path,
  //     };
  //   }
  //   return null;
  // }
  // ID(): string | null {
  //   if (this.params?.id !== null && this.params?.id !== null) {
  //     return this.params?.id?.id!;
  //   }
  //   return null;
  // }
}

export class LocalizedModel extends BaseModel {
  constructor(public readonly ar: string, public readonly en: string) {
    super();
  }

  static empty() {
    return new LocalizedModel("", "");
  }
}
