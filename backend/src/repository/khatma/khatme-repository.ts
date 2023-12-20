import { EntityTarget } from 'typeorm';
import { Repository } from "../repository";
import { CreateKhatmaReqBody } from "../../controllers/khatma-controller/requests/create-khatma/create-khatma-req-body";
import { HttpResponseError } from "../../utils/http-response-error";

import { RecitersRepository, recitersRepository } from "../reciter/reciters-repository";
import { KhatmaEntity } from '../../db/entities/khatma-entity';
import { AppPagination } from '../../middlewares/pagination.middleware';

export class KhatmeRepository extends Repository<KhatmaEntity> {

  constructor(model: EntityTarget<KhatmaEntity>, private recitersRepository: RecitersRepository) {
    super(model);
  }

  async createKhatma(request: CreateKhatmaReqBody)
    : Promise<KhatmaEntity> {


    const reciter = await this.recitersRepository
      .getOneById(request.reciterId);

    if (!reciter || !reciter.id) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterId"');
    }
    if (reciter.recitationTypes!.indexOf(request.khatmaType) < 0) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'This associated reciter does not have this "khatmaType" value which is the recitation type');
    }

    const data = new KhatmaEntity();
    data.name = request.name;
    data.recitationType = request.khatmaType;
    data.reciter = reciter;


    const result = await this.create(data);

    return result;
  }

  async getKhatme(reciterId?: number, pagination?: AppPagination) {

    let options: any = { reciter: {} };
    if (reciterId) {
      options.reciter.id = reciterId;
    }

    const data = await this.getAll({
      conditions: {
        ...options,
        ...pagination
      },
      relations: {
        reciter: true,
      }
    });
    return data;
  }

  async getKhatmaById(khatmaId: number): Promise<KhatmaEntity | null> {

    const khatmaRes = await this.getOneById(khatmaId,
      //  'reciter', 'name image bio id'
    );
    if (!khatmaRes || !khatmaRes?.id) return null;

    return khatmaRes;
  }

}

export const khatmeRepository = new KhatmeRepository(KhatmaEntity, recitersRepository);
