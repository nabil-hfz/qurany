import { RootController } from "./root-controller";
import { ReciterController } from "./reciter-controller/reciter-controller";
import { AccountController } from "./account-controller/account-controller";
import { Controller } from "./index";
import { KhatmaController } from "./khatma-controller/khatma-controller";
import { RecitationController } from "./recitation-controller/recitation-controller";

/** TODO: Set yours controllers here: */
export const CONTROLLERS: Array<Controller> = [
  new RootController(),
  new ReciterController(),
  new AccountController(),
  new KhatmaController(),
  new RecitationController(),
];
