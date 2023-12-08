import {
  Timestamp,
  DocumentReference,
} from "../firebase/firebase-data-classes";
import { BaseModel, LocalizedModel } from "./base-models";
import { Nullable } from "../utils/types";
import {  MiniFileModel } from "./file-model";

export class ReciterModel extends BaseModel {
  constructor(
    id: Nullable<DocumentReference>,
    public readonly bio: LocalizedModel,
    public readonly image: MiniFileModel,
    public readonly name: LocalizedModel,

    public readonly numberOfSeals: number,
    public readonly totalDownloads: number,
    public readonly totalPlays: number,
    public readonly createdAt: Timestamp = Timestamp.now()
  ) {
    super(createdAt, id);
  }

  static empty() {
    return new ReciterModel(
      null,
      LocalizedModel.empty(),
      MiniFileModel.empty(),
      LocalizedModel.empty(),
      0,
      0,
      0
    );
  }
}

export class ReciterMiniModel extends BaseModel {
  constructor(
    id: Nullable<DocumentReference>,
    public readonly image: MiniFileModel,
    public readonly name: LocalizedModel,
  ) {

    super(null, id);
  }

  static empty() {
    return new ReciterMiniModel(
      null,
      MiniFileModel.empty(),
      LocalizedModel.empty(),
    );
  }
}
