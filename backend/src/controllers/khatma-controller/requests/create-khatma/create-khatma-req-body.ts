import { LocalizedModel } from "../../../../models/base-models";

export type CreateKhatmaReqBody = {
  // public:
  reciterId: string;
  name: LocalizedModel;
  type: number;

};
