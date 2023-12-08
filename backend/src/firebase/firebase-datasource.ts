import { Auth } from "firebase-admin/lib/auth/auth";
import { Firestore } from "firebase-admin/firestore";
import * as functions from "firebase-functions";
import { FirebaseApp } from "../firebase/initialize";
import { AppConst } from "../constant/app.const";

class FirebaseDatasource {
  private readonly fireStoreDb = FirebaseApp.firestore();

  constructor() {
    this.fireStoreDb.settings({ ignoreUndefinedProperties: true });
  }


  public storage() {
    return FirebaseApp.storage();
 
  }


  public database() {
    return FirebaseApp.database;
  }

  public auth(): Auth {
    return FirebaseApp.auth();
  }

  public firestore(): Firestore {
    return this.fireStoreDb;
  }

  public functions() {
    return functions;
  }

  public appLogger() {
    return functions.logger;
  }

  public handleRequests(app: any): functions.HttpsFunction {
    // functions.https.on
    return functions.region(AppConst.REGION).https.onRequest(app);
  }
}

const firebaseDep = new FirebaseDatasource();
export {firebaseDep};

 
