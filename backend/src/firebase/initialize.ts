import * as admin from "firebase-admin";
import * as path from "path";
import { currentEnv } from "../config";


export const CURRENT_GCLOUD_PROJECT = process.env.GCLOUD_PROJECT as string;

const serviceAccoun = path.resolve(process.cwd(), `./.keys/firebase-adminsdk-${currentEnv}.json`);
console.log('serviceAccoun is ',serviceAccoun);
const credential = admin.credential.cert(serviceAccoun);

const FirebaseApp: admin.app.App = admin.initializeApp({
  credential: credential,
  storageBucket: `${CURRENT_GCLOUD_PROJECT}.appspot.com`,
  databaseURL: `https://${CURRENT_GCLOUD_PROJECT}.firebaseio.com`,
});
export { FirebaseApp };
