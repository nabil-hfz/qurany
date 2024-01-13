import { LocalizedEntity } from "../../../../db/entities/localized.entity";


export type CreateKhatmaReqBody = {
  // public:
  reciterId: number;
  name: LocalizedEntity;
  khatmaType: number;

};
