import { Repository } from "../repository";
import { HttpResponseError } from "../../utils/http-response-error";
import { uploaderService } from "../../services/uploader-service";
import { logInfo } from "../../utils/logger";
import { AppStoragePathsConst } from "../../constant/app-storage-paths.const";
import { EntityTarget } from "typeorm";
import { UserEntity } from "../../db/entities/user.entity";
import { CreateAccountReqBody } from "../../controllers/account-controller/requests/create-account/create-account-req-body";
import { FileEntity } from "../../db/entities/file.entity";
import { AppPasswordUtils } from "../../utils/password-utils";

export class AccountRepository extends Repository<UserEntity> {

  constructor(model: EntityTarget<UserEntity>) {
    super(model);
  }

  async createUser(
    request: CreateAccountReqBody,
    image?: Express.Multer.File,
  ): Promise<UserEntity> {


    let filesResult: FileEntity | undefined;

    if (image) {
      const imagePath = AppStoragePathsConst.imagesUserPath;
      logInfo('imagePath is: ' + imagePath);
      filesResult = await uploaderService
        .saveFile(image, imagePath);
    }

    // let isExisted = await this._repository.exists({
    //   where: {
    //     email: request.email
    //   }
    // });

    // if (isExisted) {
    //   throw new HttpResponseError(
    //     400,
    //     "EXISTING_EMAIL",
    //     "Email is already in use"
    //   );
    // }

    let user: UserEntity = new UserEntity();

    if (filesResult) {
      user.photo = filesResult!;
    }
    user.email = request.email;
    user.displayName = request.name;
    user.customClaims = { 'role': request.role };

    let hashedPassword = await AppPasswordUtils.encryptPassword(request.password);
    user.password = hashedPassword;


    const resource = await this.create(user);
    return resource;
  }

  async login(
    email: string,
    password: string
  ): Promise<UserEntity> {
    console.log(`AccountRepository _repository is ${this._repository} `);
    let isExisted = await this._repository.exists({
      where: { email: email }
    });
    console.log(`AccountRepository isExisted is ${isExisted} `);
    if (!isExisted) {
      throw new HttpResponseError(
        400,
        "WRONG_CREDENTIALS",
        "Email or password is wrong"
      );
    }

    let user = await this._repository.findOneBy({
      email: email
    });
    console.log(`AccountRepository user is ${user} `);

    if (!user) {
      throw new HttpResponseError(
        400,
        "WRONG_CREDENTIALS",
        "Email or password is wrong"
      );
    }
    console.log('user ', user);

    let samePassword = await AppPasswordUtils.comparPassword(password, user!.password!);
    console.log(`AccountRepository samePassword is ${samePassword} `);

    if (!samePassword) {
      throw new HttpResponseError(
        400,
        "WRONG_CREDENTIALS",
        "Email or password is wrong"
      );
    }



    user.password = password;
    return user;
  }

  async getUserProfile(resourceId: number): Promise<UserEntity | null> {
    const resource = await this.getOneById(resourceId);
    if (!resource || !resource?.id) {
      return null;
    }

    return resource;
  }

}

export const accountsRepository = new AccountRepository(UserEntity);
