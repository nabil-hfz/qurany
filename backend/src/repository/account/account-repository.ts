import { Repository } from "../repository";
import { CreateRecitationReqBody } from "../../controllers/recitation-controller/requests/create-recitation/create-recitation-req-body";
import { HttpResponseError } from "../../utils/http-response-error";
import { uploaderService } from "../../services/uploader-service";
import { logInfo } from "../../utils/logger";
import { FilesRepository, filesRepository } from "../file/files-repository";
import { AppAudiosConst, AppImagesKhatmeConst } from "../../constant/app-storage-paths.const";
import { EntityTarget } from "typeorm";
import { ReciterEntity } from "../../db/entities/reciter.entity";
import { UserEntity } from "../../db/entities/user.entity";

export class AccountRepository extends Repository<UserEntity> {

  constructor(
    model: EntityTarget<UserEntity>,
    private filesRepository: FilesRepository
  ) {
    super(model);
  }

  async createUser(
    request: CreateRecitationReqBody,
    image: Express.Multer.File,
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
    const docs: UserEntity[] = filesResult.map((data) => {
      const result = new UserEntity();

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


    const savedRecitation = await this.createAll(docs);

  }
  async login(
    email: string,
    password: string
  ) {



    return await this.getAll();
  }

  async getUserProfile(resourceId: number): Promise<UserEntity | null> {
    const resource = await this.getOneById(resourceId);
    if (!resource || !resource?.id) {
      return null;
    }

    return resource;
  }

}

export const accountsService = new AccountRepository(
  UserEntity,
  filesRepository
);
