import { Repository } from "../repository";
import { CreateRecitationReqBody } from "../../controllers/recitation-controller/requests/create-recitation/create-recitation-req-body";
import { HttpResponseError } from "../../utils/http-response-error";
import { uploaderService } from "../../services/uploader-service";
import { logInfo } from "../../utils/logger";
import { FilesRepository, filesRepository } from "../file/files-repository";
import { AppAudiosConst, AppImagesKhatmeConst } from "../../constant/app-storage-paths.const";
import { KhatmeRepository, khatmeRepository } from "../khatma/khatme-repository";
import { EntityTarget } from "typeorm";
import { RecitationEntity } from "../../db/entities/recitation.entity";
import { ReciterEntity } from "../../db/entities/reciter.entity";
import { AppPagination } from "../../middlewares/pagination.middleware";

export class RecitationRepository extends Repository<RecitationEntity> {

  constructor(
    model: EntityTarget<RecitationEntity>,
    private filesRepository: FilesRepository,
    private khatmeRepository: KhatmeRepository) {
    super(model);
  }

  async createRecitations(
    request: CreateRecitationReqBody,
    images: Express.Multer.File[],
    audios: Express.Multer.File[]
  ): Promise<any> {

    const khatmaId = Number(request.khatmaId);

    const khatma = await this.khatmeRepository.getOneById(khatmaId);

    if (!khatma || !khatma?.id) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No khatma found with this "khatmaId"');
    }

    const reciter: ReciterEntity | undefined = khatma.reciter;
    const reciterId: number | undefined = reciter?.id;
    if (!reciter || !reciterId) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "khatmaId"');
    }


    const reciterIndex = reciter.reciterIndex;

    const audiosPath = AppAudiosConst[reciterIndex] + `/${khatma.recitationType}`;
    const imagesPath = AppImagesKhatmeConst[reciterIndex] + `/${khatma.recitationType}`;


    logInfo('khatmaId is: ' + khatmaId);
    logInfo('audiosPath is: ' + audiosPath);
    logInfo('imagesPath is: ' + imagesPath);

    const filesResult = await uploaderService
      .handleFiles(images, audios, audiosPath, imagesPath);

    if (!filesResult || !filesResult.length) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "filesResult"');
    }



    let index = Number(request.sequence) ?? 1;
    const docs: RecitationEntity[] = filesResult.map((data) => {
      const result = new RecitationEntity();

      result.audio = data.audioFile;
      result.durationInMilli = data.duration;
      result.image = data.imageFile;

      result.name = {
        en: `Chapter ${index}`,
        ar: `الجزء ${index}`,
      };
      result.sequence = index;
      result.reciter = reciter;
      result.khatmaId = khatmaId;
      index += 1;
      return result;
    }) ?? [];




    const imgs = docs.map(recitation => recitation.image);
    const auds = docs.map(recitation => recitation.audio);
    await this.filesRepository.createAll(imgs);
    await this.filesRepository.createAll(auds);

    const savedRecitation = await this.createAll(docs,);

    const temp = savedRecitation?.map(recitation => ({
      id: recitation?.id,
      audio: recitation?.audio.url,
      image: recitation?.image.url,
      title: recitation?.name,
    }));

    return temp;
  }

  async getRecitationById(recitationId: number): Promise<RecitationEntity | null> {
    const recitationRes = await this.getOneById(recitationId
      // , "image audio reciter"
    );
    if (!recitationRes || !recitationRes?.id) {
      return null;
    }

    return recitationRes;
  }

  async getRecitations(
    reciterId: number | undefined,
    khatmaId: number | undefined,
    pagination?: AppPagination
  ) {
    let options: any = { reciter: {} };

    if (khatmaId) {
      options.khatmaId = khatmaId;
    }

    if (reciterId) {
      options.reciter.id = reciterId;
    }

    return await this.getAll(
      {
        conditions: {
          ...options,
          ...pagination
        },
        relations: {
          image: true,
          audio: true,
          reciter: true,
        }
      }

    );
  }
}

export const recitationRepository = new RecitationRepository(
  RecitationEntity,
  filesRepository,
  khatmeRepository
);
