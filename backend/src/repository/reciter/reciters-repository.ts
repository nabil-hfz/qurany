import { FileModel, MiniFileModel } from './../../models/file-model';
import { ReciterModel } from "../../models/reciter-models";
import { Repository } from "../repository";
import { AppFirebaseCollections } from "../../firebase/collections";
import { CreateReciterReqBody } from "../../controllers/reciter-controller/requests/create-reciter/create-reciter-req-body";
import { Timestamp } from "../../firebase/firebase-data-classes";
import { serializeFS } from "../../utils/serialize-firestore";
import { HttpResponseError } from '../../utils/http-response-error';

export class RecitersRepository extends Repository {
  recitersCollection = AppFirebaseCollections.recitersCollection;


  async createReciter(request: CreateReciterReqBody, imageFile: FileModel)
    : Promise<ReciterModel> {
    const ref = this.getCollectionReference(this.recitersCollection).doc();

    await this
      .getCollectionReference(AppFirebaseCollections.filesImageCollection)
      .doc(imageFile.id?.id ?? '').set(serializeFS(imageFile));

    const data = new ReciterModel(
      ref,
      request.bio,
      new MiniFileModel(imageFile.url, imageFile?.id),
      request.name,
      Number(request.numberKhatme??1), 
      0, 
      0,
      Timestamp.now());
    await ref.set(serializeFS(data));
    return data;
  }

  async getReciters(): Promise<ReciterModel[]> {
    const snapshot = await this.getCollectionReference(this.recitersCollection).get();
    return snapshot.docs.map((doc) =>
      Object.assign(ReciterModel.empty(), doc.data())
    );
  }

  async getReciterById(reciterId: string): Promise<ReciterModel | null> {

    const reciterRes = await this.getDocumentReference(
      this.recitersCollection,
      reciterId
    ).get();
    console.log(reciterRes)
    if (!reciterRes.exists || reciterRes?.data() == null) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterId"');

    }
    return Object.assign(ReciterModel.empty(), reciterRes.data()!);
  }
}

export const recitersRepository = new RecitersRepository();
