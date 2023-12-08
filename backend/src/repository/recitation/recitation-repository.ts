import { Repository } from "../repository";
import { AppFirebaseCollections, statusLables } from "../../firebase/collections";
import { CreateRecitationReqBody } from "../../controllers/recitation-controller/requests/create-recitation/create-recitation-req-body";
import { DocumentReference, Timestamp } from "../../firebase/firebase-data-classes";
import { serializeFS } from "../../utils/serialize-firestore";
import { RecitationModel } from "../../models/recitation-model";
import { HttpResponseError } from "../../utils/http-response-error";
import { uploaderService } from "../../services/uploader-service";
import { logInfo } from "../../utils/logger";
import { MiniFileModel } from "../../models/file-model";
import { DocumentData } from "firebase-admin/firestore";

export class RecitationRepository extends Repository {
  recitationCollection = AppFirebaseCollections.recitationsCollection;
  recitersCollection = AppFirebaseCollections.recitersCollection;
  khatmeCollection = AppFirebaseCollections.khatmeCollection;

  async createRecitations(request: CreateRecitationReqBody,
    images: Express.Multer.File[],
    audios: Express.Multer.File[]
  ): Promise<any[]> {

    const khatmaId = request.khatmaId;
    const reciterIndex = request.reciterIndex
    const currentFilesPath = statusLables[reciterIndex];

    if (!audios || !audios.length) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "audios"');
    }

    if (!images || !images.length) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "images"');
    }

    if (reciterIndex >= statusLables.length || !currentFilesPath) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "reciterIndex"');
    }

    const audiosPath = AppFirebaseCollections.audiosStoragePath + currentFilesPath;
    const imagesPath = AppFirebaseCollections.imagesStoragePath + currentFilesPath;


    logInfo('khatmaId is: ' + khatmaId);
    logInfo('audiosPath is: ' + audiosPath);
    logInfo('imagesPath is: ' + imagesPath);

    const filesResult = await uploaderService
      .handleFiles(images, audios, audiosPath, imagesPath);

    if (!filesResult || !filesResult.length) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No files found "filesResult"');
    }

    const khatmaRef: DocumentReference = this.getDocumentReference(this.khatmeCollection, khatmaId)
    const khatmaResult = await khatmaRef.get();
    if (!khatmaResult.exists) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No khatma found with this "khatmaId"');
    }
    const reciterId = khatmaResult?.data()?.reciter.id;
    if (!reciterId || !reciterId.id) {
      throw new HttpResponseError(400, "BAD_REQUEST", 'No reciter found with this "khatmaId"');
    }

    const reciterResult = await reciterId.get();

    const reciterMiniModel = {
      id: reciterResult.data()?.id,
      image: reciterResult.data()?.image,
      name: reciterResult.data()?.name,
    };

    // image: new MiniFileModel(data.imageFile.url, data.imageFile?.id),
    // audio: new MiniFileModel(data.audioFile.url, data.audioFile?.id),
    let index = 0;
    const docRefs: RecitationModel[] = filesResult.map((data) => {
      index += 1;
      return {
        audio: data.audioFile,
        image: data.imageFile,
        title: {
          en: `Chapter ${index}`,
          ar: `الجزء ${index}`,
        },
        khatmaId: khatmaRef,
        sequence: index,
        reciter: reciterMiniModel,
        totalDownloads: 0,
        totalPlays: 0,
        duration: data.duration,
        createdAt: Timestamp.now(),
      } as RecitationModel;
    }) ?? [];
    const batch = this.getBatch();
    const recitationsResult = docRefs.map((recitation) => {

      const imageRef = this
        .getCollectionReference(AppFirebaseCollections.filesImageCollection)
        .doc(recitation.image.id?.id ?? '');
      batch.set(imageRef, serializeFS(recitation.image))

      const audioRef = this
        .getCollectionReference(AppFirebaseCollections.filesAudioCollection)
        .doc(recitation.audio.id?.id ?? '');
      batch.set(audioRef, serializeFS(recitation.audio))

      const ref =
        this.getCollectionReference(this.recitationCollection)
          .doc();

      batch.set(ref, serializeFS({
        ...recitation,
        image: new MiniFileModel(recitation.image.url, recitation.image?.id),
        audio: new MiniFileModel(recitation.audio.url, recitation.audio?.id),
      }))

      return { recitation, id: ref.id };
    });
    await batch.commit();




    const temp = recitationsResult.map(recitation => ({
      id: recitation.id,
      audio: recitation.recitation.audio.url,
      image: recitation.recitation.image.url,
      title: recitation.recitation.title,
    }));
    return temp;
  }

  async getRecitationById(recitationId: string): Promise<RecitationModel | null> {
    const recitationRes = await this.getDocumentReference(
      this.recitationCollection,
      recitationId
    ).get();
    if (!recitationRes.exists) {
      return null;
    }
    return this.mapData(recitationRes.data()!, recitationRes.ref);
  }

  async getRecitations(): Promise<RecitationModel[]> {
    const snapshot = await this.getCollectionReference(this.recitationCollection).get();
    return snapshot.docs.map((doc) => this.mapData(doc.data(), doc.ref));
  }

  mapData(data: DocumentData, ref: DocumentReference) {
    return new RecitationModel(
      ref,
      data.audio,
      data.image,
      data.title,
      data.khatmaId,
      data.index,
      data.reciter,
      data.totalDownloads,
      data.totalPlays,
      data.duration,
      data.createdAt,
    );
  }
}

export const recitationRepository = new RecitationRepository();
