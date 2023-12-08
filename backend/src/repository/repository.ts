import { Model } from 'mongoose';
import {
  FieldValue,
  OrderByDirection,
  WhereFilterOp,
  WriteResult,
} from "firebase-admin/firestore";
import { InvalidDataException } from "../exceptions/data-excption";
import { DocumentData, uuid } from "../utils/types";

export abstract class Repository<T extends Document> {
  protected model: Model<T>;

  constructor(model: Model<T>) {
    this.model = model;
  }

  public async getDocument(documentId: string): Promise<T | null> {
    try {
      return await this.model.findById(documentId).exec();
    } catch (error) {
      console.error(`Error getting document with id ${documentId}`, error);
      return null;
    }
  }

  public getCollectionReference(collection: string) {
    return this.db.collection(collection);
  }

  public getSubDocumentReference(
    collection: string,
    documentId: uuid,
    subCollection: string,
    subDocumentId: uuid
  ) {
    return this.db
      .collection(collection)
      .doc(documentId)
      .collection(subCollection)
      .doc(subDocumentId);
  }

  public getSubSubCollectionReference(
    collection: string,
    documentId: uuid,
    subCollection: string,
    subDocumentId: uuid,
    documentSubCollection: string
  ) {
    return this.db
      .collection(collection)
      .doc(documentId)
      .collection(subCollection)
      .doc(subDocumentId)
      .collection(documentSubCollection);
  }

  public getSubCollectionReference(
    collection: string,
    documentId: uuid,
    subCollection: string
  ) {
    return this.db
      .collection(collection)
      .doc(documentId)
      .collection(subCollection);
  }

  // public async getDocument(
  //   collection: string,
  //   documentId: uuid
  // ): Promise<DocumentData | undefined> {
  //   const docRef = this.db.collection(collection).doc(documentId);
  //   try {
  //     const doc = await docRef.get();
  //     if (doc.exists) {
  //       return doc.data();
  //     } else {
  //       // doc.data() will be undefined in this case
  //       console.log(`${collection}=>${documentId} (No such document!)`);
  //       return undefined;
  //     }
  //   } catch (error) {
  //     console.log(`Error getting document ${collection}=>${documentId}`, error);
  //     return undefined;
  //   }
  // }

  protected async findDocuments(
    collection: string,
    field: string,
    opStr: WhereFilterOp,
    value: any,
    orderBy?: string,
    orderByDirection?: OrderByDirection
  ): Promise<FirebaseFirestore.DocumentData[]> {
    let docRef;

    if (orderBy && orderByDirection) {
      docRef = this.db
        .collection(collection)
        .where(field, opStr, value)
        .orderBy(orderBy, orderByDirection);
    }

    docRef = this.db.collection(collection).where(field, opStr, value);
    const querySnapshot = await docRef.get();
    if (querySnapshot.empty) {
      return [];
    }

    const data: FirebaseFirestore.DocumentData[] = [];
    querySnapshot.forEach((doc) => {
      data.push({ id: doc.id, ...doc.data() });
    });

    return data;
  }

  public async getSubDocument(
    collection: string,
    documentId: uuid,
    subCollection: string,
    subDocumentId: uuid
  ): Promise<DocumentData | undefined> {
    const docRef = this.db
      .collection(collection)
      .doc(documentId)
      .collection(subCollection)
      .doc(subDocumentId);
    try {
      const doc = await docRef.get();
      if (doc.exists) {
        return doc.data();
      } else {
        // doc.data() will be undefined in this case
        console.log(`${collection}=>${documentId} (No such document!)`);
        return undefined;
      }
    } catch (error) {
      console.log(`Error getting document ${collection}=>${documentId}`, error);
      throw new InvalidDataException({ error: error });
    }
  }

  public async getDocumentSubCollection(
    collection: string,
    documentId: uuid,
    subCollection: string,
    sortBy?: string
  ) {
    try {
      let docRef;

      if (sortBy && sortBy != "") {
        docRef = this.db
          .collection(collection)
          .doc(documentId)
          .collection(subCollection)
          .orderBy(sortBy, "desc");
      } else {
        docRef = this.db
          .collection(collection)
          .doc(documentId)
          .collection(subCollection);
      }

      const querySnapshot = await docRef.get();
      if (querySnapshot) {
        if (querySnapshot.empty) {
          throw new InvalidDataException({
            error: `empty document ${collection}.${documentId}.${subCollection}`,
          });
        }

        const data: FirebaseFirestore.DocumentData[] = [];
        querySnapshot.forEach((doc) => {
          data.push(doc.data());
        });

        return data;
      } else {
        // doc.data() will be undefined in this case
        console.log("No such document!");
        throw new InvalidDataException({
          error: `invalid document ${collection}.${documentId}.${subCollection}`,
        });
      }
    } catch (error) {
      console.log("Error getting document:", error);
      throw new InvalidDataException({ error: error });
    }
  }

  public async updateFieldByDelta(
    collection: string,
    docId: string,
    field: string,
    delta: number
  ) {
    const postRef = this.getDocumentReference(collection, docId);
    return postRef.update({
      [field]: FieldValue.increment(delta),
    });
  }

  public async updateFieldByRecord(
    collection: string,
    docId: string,
    record: Record<string, any>
  ): Promise<WriteResult> {
    const postRef = this.getDocumentReference(collection, docId);
    return postRef.update(record);
  }

  public async findDocumentsWhereMatch(
    collection: string,
    field: string,
    value: string
  ) {
    const querySnapshot = await this.getCollectionReference(collection).get();
    const filteredDocuments = <any>[];
    for (const doc of querySnapshot.docs) {
      const docValue = doc.get(field);
      if (
        docValue &&
        (docValue as string).toLowerCase().includes(value.toLowerCase())
      ) {
        filteredDocuments.push(doc);
      }
    }
    return filteredDocuments;
  }

  public getBatch() {
    return this.db.batch();
  }

  public paginate(array: any, page_number: number, page_size = 20) {
    page_number = page_number + 1;
    // human-readable page numbers usually start with 1, so we reduce 1 in the first argument
    return array.slice((page_number - 1) * page_size, page_number * page_size);
  }
}
