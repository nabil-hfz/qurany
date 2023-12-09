import { Repository } from "../repository";
import { AppFirebaseCollections, statusLables } from "../../firebase/collections";
import { CreateRecitationReqBody } from "../../controllers/recitation-controller/requests/create-recitation/create-recitation-req-body";
import { IRecitationModel, RecitationModel } from "../../models/recitation-model";
import { HttpResponseError } from "../../utils/http-response-error";
import { uploaderService } from "../../services/uploader-service";
import { logInfo } from "../../utils/logger";
import { Model } from "mongoose";
import { IReciterModel } from "../../models/reciter-models";
import { FilesRepository, filesRepository } from "../file/files-repository";

export class RecitationRepository extends Repository<IRecitationModel> {

  constructor(model: Model<IRecitationModel>, private filesRepository: FilesRepository) {
    super(model);
  }

  async createRecitations(
    request: CreateRecitationReqBody,
    images: Express.Multer.File[],
    audios: Express.Multer.File[]
  ): Promise<any> {

    const khatmaId = request.khatmaId;
    const reciterIndex = request.reciterIndex
    const currentFilesPath = statusLables[reciterIndex];


    const audiosPath = AppFirebaseCollections.audiosStoragePath + currentFilesPath;
    const imagesPath = AppFirebaseCollections.imagesStoragePath + currentFilesPath;


    logInfo('khatmaId is: ' + khatmaId);
    logInfo('audiosPath is: ' + audiosPath);
    logInfo('imagesPath is: ' + imagesPath);

    const filesResult = await uploaderService
      .handleFiles(images, audios, audiosPath, imagesPath);

    if (!filesResult || !filesResult.length) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "filesResult"');
    }

    const khatma = await this.getOneById(khatmaId)
    if (!khatma || !khatma?.id) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No khatma found with this "khatmaId"');
    }

    const reciter: IReciterModel = khatma.reciter;
    const reciterId: string = reciter.id;
    if (!reciter || !reciterId || !reciterId?.length) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "khatmaId"');
    }



    let index = 0;
    const docs: IRecitationModel[] = filesResult.map((data) => {
      index += 1;
      return {
        audio: data.audioFile,
        duration: data.duration,
        image: data.imageFile,
        title: {
          en: `Chapter ${index}`,
          ar: `الجزء ${index}`,
        },
        sequence: index,
        reciter: reciter,
        khatmaId: khatmaId,
      } as IRecitationModel;
    }) ?? [];




    const imgs = docs.map(recitation => recitation.image);
    const auds = docs.map(recitation => recitation.audio);
    await this.filesRepository.createAll(imgs);
    await this.filesRepository.createAll(auds);

    const savedRecitation = await this.createAll(docs);

    const temp = savedRecitation?.map(recitation => ({
      id: recitation?.id,
      audio: recitation?.audio.url,
      image: recitation?.image.url,
      title: recitation?.title,
    }));

    return temp;
  }

  async getRecitationById(recitationId: string): Promise<IRecitationModel | null> {
    const recitationRes = await this.getOneById(recitationId);
    if (!recitationRes || !recitationRes?.id) {
      return null;
    }

    return recitationRes;
  }

  async getRecitations() {
    return await this.getAll({});
  }
}

export const recitationRepository = new RecitationRepository(RecitationModel, filesRepository);
