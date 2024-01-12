import { LocalizedEntity } from "../../../../db/entities/localized.entity";


export type CreateReciterReqBody = {
  // public:
  bio: LocalizedEntity;
  reciterIndex: number;
  name: LocalizedEntity;
  numberOfKhatmat: number;
  recitationTypes: number[];
};
