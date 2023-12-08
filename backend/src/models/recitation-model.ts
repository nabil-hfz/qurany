import { ReciterMiniModel } from './reciter-models';
import {
    DocumentReference,
    Timestamp,
} from "../firebase/firebase-data-classes";
import { BaseModel, LocalizedModel } from "./base-models";
import { Nullable } from '../utils/types';
import { FileModel } from './file-model';

export class RecitationModel extends BaseModel {
    constructor(
        id: Nullable<DocumentReference>,
        public readonly audio: FileModel,
        public readonly image: FileModel,
        public readonly title: LocalizedModel,
        public readonly khatmaId: Nullable<DocumentReference>,
        public readonly sequence: number,
        public readonly reciter: ReciterMiniModel,
        public readonly totalDownloads: number,
        public readonly totalPlays: number,
        public readonly duration: number,
        public readonly createdAt: Timestamp = Timestamp.now()
    ) {
        super(createdAt, id);
    }

    static empty(ref: string | null = null) {
        return new RecitationModel(
            null,
            FileModel.empty(),
            FileModel.empty(),
            LocalizedModel.empty(),
            null,
            0,
            ReciterMiniModel.empty(),
            0,
            0,
            0,
        );
    }
}
