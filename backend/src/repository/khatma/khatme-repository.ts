import { Repository } from "../repository";
import { CreateKhatmaReqBody } from "../../controllers/khatma-controller/requests/create-khatma/create-khatma-req-body";
import { HttpResponseError } from "../../utils/http-response-error";

import { Model } from "mongoose";
import { RecitersRepository, recitersRepository } from "../reciter/reciters-repository";
import { IKhatmaModel, KhatmaModel } from "../../models/khatma-model";

export class KhatmeRepository extends Repository<IKhatmaModel> {

  constructor(model: Model<IKhatmaModel>, private recitersRepository: RecitersRepository) {
    super(model);
  }

  async createKhatma(request: CreateKhatmaReqBody)
    : Promise<{ khatmaId: string; }> {


    const reciter = await this.recitersRepository
      .getOneById(request.reciterId);

    if (!reciter || !reciter.id) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterId"');
    }

    const data = {
      name: request.name,
      type: request.type,
      reciter: reciter,
    } as IKhatmaModel;
    const result = await this.create(data);

    return { khatmaId: result?.id };
  }

  async getKhatmaById(khatmaId: string): Promise<IKhatmaModel | null> {

    const khatmaRes = await this.getOneById(khatmaId);
    if (!khatmaRes || !khatmaRes?.id) return null;

    return khatmaRes;
  }

  async getKhatme() {
    const data = await this.getAll({});
    return data;
  }
}

export const khatmeRepository = new KhatmeRepository(KhatmaModel, recitersRepository);
