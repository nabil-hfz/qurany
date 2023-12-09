import { ILocalizedModel } from "../../../../models/localized-model";


export type CreateKhatmaReqBody = {
  // public:
  reciterId: string;
  name: ILocalizedModel;
  type: number;

};
