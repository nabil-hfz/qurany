import { UserEntity } from "../../../db/entities/user.entity";

export class CreateAccountResBody {
  public readonly status;
  public readonly uid;

  public readonly tutorial =
    "Success!!! Next steps: In your client side (Flutter or JavaScript), you should 'signInWithEmailAndPassword'. After, set the header 'Authorization' with the result of the 'getIdToken' function that is on the Firebase Authentication package for client side";

  constructor(user: UserEntity) {
    this.uid = user.id;
    this.status = "USER_CREATED_SUCCESSFULLY";
  }
}
