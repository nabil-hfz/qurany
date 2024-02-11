import { UserEntity } from "../../../db/entities/user.entity";

export class CreateAccountResBody {
  public readonly uid;

  constructor(user: UserEntity) {
    this.uid = user.id;
  }
}
