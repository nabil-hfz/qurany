// import { serializeFS } from "../../utils/serialize-firestore";
// import { firestore } from "firebase-admin";
// import {Timestamp} from "../../firebase/firebase-data-classes";

import { Repository } from "../repository";
import { AppFirebaseCollections } from "../../firebase/collections";
import { CreateKhatmaReqBody } from "../../controllers/khatma-controller/requests/create-khatma/create-khatma-req-body";
import { Timestamp } from "../../firebase/firebase-data-classes";
import { serializeFS } from "../../utils/serialize-firestore";
import { KhatmaModel } from "../../models/khatma-model";
import { HttpResponseError } from "../../utils/http-response-error";
import { DocumentData } from "firebase-admin/firestore";
import { ReciterMiniModel } from "../../models/reciter-models";
import { MiniFileModel } from "../../models/file-model";

export class KhatmeRepository extends Repository {
  khatmeCollection = AppFirebaseCollections.khatmeCollection;
  recitersCollection = AppFirebaseCollections.recitersCollection;

  async createKhatma(request: CreateKhatmaReqBody)
    : Promise<{ khatmaId: string; }> {
    const khatmaRef = this.getCollectionReference(this.khatmeCollection).doc();


    const reciterResult = await this.getCollectionReference(this.recitersCollection)
      .doc(request.reciterId)
      .get();

    if (!reciterResult || !reciterResult.id) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterId"');
    }
    const img = reciterResult.data()?.image;
    const reciterMiniModel = {
      id: reciterResult.data()?.id,
      image: new MiniFileModel(img.url, img?.id),
      name: reciterResult.data()?.name,
    };

    const newKhatma = {
      name: request.name,
      reciter: reciterMiniModel,
      type: request.type,
      totalPlays: 0,
      totalDownloads: 0,
      createdAt: Timestamp.now(),
    } as KhatmaModel;


    await khatmaRef.set(serializeFS(newKhatma));

    return {  khatmaId: khatmaRef.id };
  }

  async getKhatmaById(khatmaId: string): Promise<KhatmaModel | null> {
    // console.log('khatmaId is ',khatmaId);
    const khatmaRes = await this.getDocumentReference(
      this.khatmeCollection,
      khatmaId
    ).get();
    if (!khatmaRes.exists) return null;


    return this.mapData(khatmaRes);
  }

  async getKhatme(): Promise<KhatmaModel[]> {
    const snapshot = await this.getCollectionReference(this.khatmeCollection).get();
    return snapshot.docs.map((doc) => this.mapData(doc)
    );
  }

  mapData(data: DocumentData) {
    return new KhatmaModel(
      data.ref,
      data.data().name,
      new ReciterMiniModel(
        data.data().reciter.id,
        data.data().reciter.image,
        data.data().reciter.name,
      ),
      data.data().type,
      data.data().totalDownloads,
      data.data().totalPlays,
      data.data().createdAt,
    );
  }
}

export const khatmeRepository = new KhatmeRepository();
