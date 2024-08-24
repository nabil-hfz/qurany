// import { LocalizedEntity } from "../../../../db/entities/localized.entity";

export type CreateReciterReqBody = {
  // public:
  bio: { [key: string]: string };
  reciterIndex: number;
  name: { [key: string]: string };
  numberOfKhatmat: number;
  recitationTypes: number[];
};
