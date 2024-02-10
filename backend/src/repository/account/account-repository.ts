import { Repository } from "../repository";
import { CreateRecitationReqBody } from "../../controllers/recitation-controller/requests/create-recitation/create-recitation-req-body";
import { HttpResponseError } from "../../utils/http-response-error";
import { uploaderService } from "../../services/uploader-service";
import { logInfo } from "../../utils/logger";
import { FilesRepository, filesRepository } from "../file/files-repository";
import { AppAudiosConst, AppImagesKhatmeConst, AppStoragePathsConst } from "../../constant/app-storage-paths.const";
import { EntityTarget } from "typeorm";
import { ReciterEntity } from "../../db/entities/reciter.entity";
import { UserEntity } from "../../db/entities/user.entity";
import { CreateAccountReqBody } from "../../controllers/account-controller/requests/create-account/create-account-req-body";
import { FileEntity } from "../../db/entities/file.entity";

export class AccountRepository extends Repository<UserEntity> {

  constructor(
    model: EntityTarget<UserEntity>,
    private filesRepository: FilesRepository
  ) {
    super(model);
  }

  async createUser(
    request: CreateAccountReqBody,
    image: Express.Multer.File,
  ): Promise<any> {


    let filesResult: FileEntity;

    if (image) {
      const imagePath = AppStoragePathsConst.imagesUserPath;
      logInfo('imagePath is: ' + imagePath);
      filesResult = await uploaderService
        .saveFile(image, imagePath);
    }

    let isExisted = this._repository.exists({
      where: {
        email: request.email
      }
    });

    let user: UserEntity = new UserEntity();



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
