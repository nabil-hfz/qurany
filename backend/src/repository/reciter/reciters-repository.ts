
import { Repository } from "../repository";
import { CreateReciterReqBody } from "../../controllers/reciter-controller/requests/create-reciter/create-reciter-req-body";
import { HttpResponseError } from '../../utils/http-response-error';
import { FilesRepository, filesRepository } from '../file/files-repository';
import { RecitationTypes } from '../../db/entities/recitation-entity';
import { ReciterEntity } from "../../db/entities/reciter-entity";
import { EntityTarget } from "typeorm/common/EntityTarget";
import { FileEntity } from "../../db/entities/file-entity";

export class RecitersRepository extends Repository<ReciterEntity> {

  constructor(
    model: EntityTarget<ReciterEntity>,
    private filesRepository: FilesRepository
  ) {
    super(model);
  }

  async createReciter(
    request: CreateReciterReqBody,
    imageFile: FileEntity
  ): Promise<ReciterEntity> {


    const imgResult = await this.filesRepository.create(imageFile);

    const data = new ReciterEntity();

    data.name = request.name;
    data.bio = request.bio;
    data.image = imgResult;
    data.numberOfKhatmat = request.numberOfKhatmat;
    data.recitationTypes = request.recitationTypes ?? [RecitationTypes.Hafs];


    const reciter = this.create(data);
    return reciter;
  }

  async getReciters() {
    const reciters = this.getAll({
      relations: {
        image: true,
      }
    });
    return reciters;
  }

  async getReciterById(reciterId: number): Promise<ReciterEntity | null> {

    const reciterRes = await this.getOneById(reciterId);
    if (!reciterRes || !reciterRes?.id) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        `No reciter found with this \"reciterId\": ${reciterId}`);

    }
    return reciterRes;
  }
}

export const recitersRepository = new RecitersRepository(ReciterEntity, filesRepository);
