import { UserEntity } from "../../../db/entities/user.entity";
import { Nullable } from "../../../utils/types";

export class UserAccountResBody {
  public readonly token: Nullable<string>;
  public readonly profile: Nullable<UserProfileResBody>;



  constructor(user: UserEntity, token: string) {
    this.token = token;
    this.profile = {
      uid: user.id,
      email: user.email,
      displayName: user.displayName,
      photo: user.photo?.url,
      phoneNumber: user.phoneNumber,
      customClaims: user.customClaims,

    };
  }
}


interface UserProfileResBody {
  readonly uid: number;
  readonly email: Nullable<string>;
  readonly displayName: Nullable<string>;
  readonly photo: Nullable<string>;
  readonly phoneNumber: Nullable<string>;
  readonly customClaims: Nullable<{ [key: string]: any }>;
}