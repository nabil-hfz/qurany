import { ILocalizedModel } from "../../../../models/localized-model";


export type CreateReciterReqBody = {
  // public:
  bio: ILocalizedModel;
  imagePath: string;
  name: ILocalizedModel;
  numberOfKhatmat: number;
  recitationTypes: number[];
};
