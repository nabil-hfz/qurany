import { IFileModel } from './../../models/file-model';
import { IReciterModel, ReciterModel } from "../../models/reciter-models";
import { Repository } from "../repository";
import { CreateReciterReqBody } from "../../controllers/reciter-controller/requests/create-reciter/create-reciter-req-body";
import { HttpResponseError } from '../../utils/http-response-error';
import { Model } from 'mongoose';
import { RecitationTypes } from '../../models/recitation-model';
import { FilesRepository, filesRepository } from '../file/files-repository';

export class RecitersRepository extends Repository<IReciterModel> {

  constructor(model: Model<IReciterModel>, private filesRepository: FilesRepository) {
    super(model);
  }

  async createReciter(
    request: CreateReciterReqBody,
    image: IFileModel
  ): Promise<IReciterModel> {


    const imgResult = await this.filesRepository.create(image);

    const data: Partial<IReciterModel> = {
      name: request.name,
      bio: request.bio,
      image: imgResult,
      numberOfKhatmat: request.numberOfKhatmat,
      recitationTypes: [RecitationTypes.Hafs]

    };
    const reciter = this.create(data);
    return reciter;
  }

  async getReciters() {
    const reciters = this.getAll({});
    return reciters;
  }

  async getReciterById(reciterId: string): Promise<IReciterModel | null> {

    const reciterRes = await this.getOneById(reciterId);

    console.log(reciterRes)
    if (!reciterRes || !reciterRes?.id) {
      throw new HttpResponseError(
        400,
        "BAD_REQUEST",
        `No reciter found with this \"reciterId\": ${reciterId}`);

    }
    return reciterRes;
  }
}

export const recitersRepository = new RecitersRepository(ReciterModel, filesRepository);
