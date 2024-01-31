import { Injectable } from "@angular/core";
// import { AngularFirestore } from "@angular/fire/compat/firestore";

import { from } from "rxjs";
import { concatMap, last, map, switchMap } from "rxjs/operators";


export const enum MediaType {
  Image,
  Video,
  Doc,
  Audio,
}
export interface FileData {
  mimeType: string,
  name: string,
  sizeInBytes: number,
  uploadedAt: Date,
  url: string,
  id?: string,
  duration?: number;
  type: MediaType
}
@Injectable({
  providedIn: "root",
})
export class UploadHelperService {
  constructor(
    // private storage: AngularFireStorage,
    // private db: AngularFirestore
  ) { }

  /**
   * upload helper
   * @param [File] file
   * @param [string] id
   */
  upload(
    file: File,
    id: string
  ): {
    // task: AngularFireUploadTask;
    // ref: AngularFireStorageReference;
  } {
    const filePath = `${id}/${file.name}`;
    const task = this.storage.upload(filePath, file, {
      cacheControl: "max-age=2592000,public",
    });
    const ref = this.storage.ref(filePath);
    return { task, ref };
  }

  /**
   * upload helper
   * @param [File] file
   * @param [string] id
   */
  uploadAndSave(file: File, id: string, type: MediaType = MediaType.Image, duration?: number) {
    const filePath = `${id}/${file.name}`;
    const task = this.storage.upload(filePath, file, {
      cacheControl: "max-age=2592000,public",
    });
    const ref = this.storage.ref(filePath);

    return task.snapshotChanges().pipe(
      last(),
      concatMap(() => ref.getDownloadURL()),
      switchMap((url) => {
        let fileData: FileData = {
          mimeType: file.type,
          name: file.name,
          sizeInBytes: file.size,
          uploadedAt: new Date(),
          url: url,
          id: this.db.createId(),
          type
        };

        if (duration) fileData.duration = duration

        return this.saveAsDoc(fileData).pipe(
          map((res) => {
            return { ...fileData };
          })
        );
      })
    );
  }

  getFileData(id: string) {
    return this.db
      .collection<any>("uploads")
      .doc(id)
      .get()
      .pipe(map((res) => convertSnap<FileData>(res)));
  }

  getFilesData(ids: string[]) {
    return this.db
      .collection<any>("uploads", ref => ref.where('id', 'in', [...ids])).get().pipe(map(res => {
        return res
      }))
  }

  saveAsDoc(data: FileData) {
    const pro = this.db.doc(`uploads/${data?.id}`).set({ ...data })

    return from(pro);
  }

  /**
   * delete image from storage by
   * @param  {string} url
   */
  deleteByRefFromUrl(url: string) {
    // this.storage.refFromURL(url).delete();
  }
}
