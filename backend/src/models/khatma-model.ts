import { ReciterMiniModel } from './reciter-models';
import { DocumentReference, Timestamp } from "../firebase/firebase-data-classes";
import { BaseModel, LocalizedModel } from "./base-models";
import { Nullable } from '../utils/types';

export class KhatmaModel extends BaseModel {
    constructor(
        id: Nullable<DocumentReference>,
        public readonly name: LocalizedModel,
        public readonly reciter: ReciterMiniModel,
        public readonly type: number,
        public readonly totalDownloads: number,
        public readonly totalPlays: number,
        public readonly createdAt: Timestamp = Timestamp.now()
    ) {
        super(createdAt, id);
    }

    static empty() {
        return new KhatmaModel(
            null,
            LocalizedModel.empty(),
            ReciterMiniModel.empty(),
            0,
            0,
            0,
        );
    }
}
