import { DocumentReference, Timestamp } from "../firebase/firebase-data-classes";
import { BaseModel } from "./base-models";

// {
//     fieldname: 'images',
//     originalname: 'Slide1.jpg',
//     encoding: '7bit',
//     mimetype: 'image/jpeg',
//     buffer: <Buffer ff d8 ff e0 00 10 4a 46 49 46 00 01 01 01 00 60 00 60 00 00 ff db 00 43 00 03 02 02 03 02 02 03 03 03 03 04 03 03 04 05 08 05 05 04 04 05 0a 07 07 06 ... 145477 more bytes>,
//     size: 145527
//   }

export class FileModel extends BaseModel {
    constructor(
        public readonly url: string,
        public readonly mimetype: string,
        public readonly size: number,
        public readonly originalname: string,
        createdAt?: Timestamp,
        id?: DocumentReference,

    ) {
        super(createdAt, id);
    }

    static empty() {
        return new FileModel(
            '',
            '',
            0,
            '',
        );
    }
}
export class MiniFileModel extends BaseModel {
    constructor(
        public readonly url: string,
        id?: DocumentReference|null,

    ) {
        super(null, id);
    }

    static empty() {
        return new MiniFileModel(
            '',
        );
    }
}
