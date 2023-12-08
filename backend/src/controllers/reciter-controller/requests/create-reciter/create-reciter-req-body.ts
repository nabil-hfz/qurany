import { LocalizedModel } from "../../../../models/base-models";

export type CreateReciterReqBody = {
  // public:
  bio: LocalizedModel;
  imagePath: string;
  name: LocalizedModel;
  numberKhatme: number;
};
