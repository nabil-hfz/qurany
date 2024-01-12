
import { Readable } from "node:stream";
import { CreateWriteStreamOptions } from "@google-cloud/storage";
import { v4 as uuidv4 } from 'uuid';
import { firebaseDep } from '../firebase/firebase-datasource';

import * as fs from 'fs';
import * as ffprobe from 'ffprobe';
import * as ffprobeStatic from 'ffprobe-static';
import * as tmp from 'tmp';
import { FileEntity } from "../db/entities/file.entity";
import { ThumbnailImageResponse } from "./thumbnail-service";


export class UploaderService {
    // private _onFileEvent = 'file';
    private _onErrorEvent = 'error';
    private _onFinishEvent = 'finish';
    // private _onEndEvent = 'end';

    bufferToStream(buffer: Buffer): Readable {
        const stream = new Readable();
        stream.push(buffer);
        stream.push(null);
        return stream;
    }

    async getAudioDuration(buffer: Buffer): Promise<number> {
        const tmpFile = tmp.fileSync();
        fs.writeFileSync(tmpFile.name, buffer);
        const metadata = await ffprobe(tmpFile.name, { path: ffprobeStatic.path });

        const audioStream = metadata.streams.find((stream) => stream.codec_type === 'audio');
        const durtion = Math.round(Number(audioStream?.duration) ?? 0 * 1000);

        // Clean up temp file
        fs.unlinkSync(tmpFile.name);
        tmpFile.removeCallback();

        return durtion;
    }

    private async uploadFile(
        buffer: Buffer,
        destination: string,
        contentType?: string
    ): Promise<string> {
        const stream = this.bufferToStream(buffer);
        const bucket = firebaseDep.storage().bucket();
        const options: CreateWriteStreamOptions = {
            public: true,
            resumable: true,
            timeout: 1000 * 60 * 2, // 10 min
            contentType: contentType,
            metadata: {
                contentType: contentType,
                metadata: {
                    contentType: contentType,

                    firebaseStorageDownloadTokens: uuidv4(),
                },

            }
        };
        const file = bucket.file(destination);
        return new Promise((resolve, reject) => {
            stream.pipe(
                file.createWriteStream(options)
            )
                .on(this._onErrorEvent, reject)
                .on(this._onFinishEvent, () => {
                    file.getSignedUrl(
                        {
                            action: 'read',
                            expires: '03-09-2491',
                        },
                        (err, url) => {
                            if (err) reject(err);
                            resolve(url as string);
                        }
                    );
                });
        });
    }
    async handleFiles(
        images: Express.Multer.File[],
        audios: Express.Multer.File[],
        audioLocation = "",
        imageLocation = "",

    ): Promise<Array<{ audioFile: FileEntity; imageFile: FileEntity; duration: number }>> {
        const results = [];
        if (audioLocation && audioLocation.length > 0) {
            if (audioLocation.startsWith('/'))
                audioLocation = audioLocation.substring(1);
            if (!audioLocation.endsWith('/'))
                audioLocation += '/';
        }
        if (imageLocation && imageLocation.length > 0) {
            if (imageLocation.startsWith('/'))
                imageLocation = imageLocation.substring(1);
            if (!imageLocation.endsWith('/'))
                imageLocation += '/';
        }

        for (let i = 0; i < audios.length; i++) {
            const audioBuffer = audios[i];
            const imageBuffer = images[i];
            const audioFileName = audioBuffer.originalname;
            const imageFileName = imageBuffer.originalname;

            const audioFileExt = audioBuffer.mimetype;
            const imageFileExt = imageBuffer.mimetype;
            // console.log(audios[i])
            // console.log(images[i])
            // console.log('\n\n\n')
            const audioDestination = `${audioLocation}${audioFileName}`;
            const imageDestination = `${imageLocation}${imageFileName}`;

            const audioUrl = await this.uploadFile(audioBuffer.buffer, audioDestination, audioFileExt);
            const imageUrl = await this.uploadFile(imageBuffer.buffer, imageDestination, imageFileExt);

            const duration = await this.getAudioDuration(audioBuffer.buffer);

            const audioFile = new FileEntity();
            audioFile.url = audioUrl;
            audioFile.mimeType = audioBuffer.mimetype;
            audioFile.size = audioBuffer.size;
            audioFile.name = audioFileName;

            // const refImage = firebaseDep.firestore()
            //     .collection(AppFirebaseCollections.filesImageCollection)
            //     .doc();

            const imageFile = new FileEntity();
            imageFile.url = imageUrl;
            imageFile.mimeType = imageBuffer.mimetype;
            imageFile.size = imageBuffer.size;
            imageFile.name = imageFileName;

            // const imageFile = new FileEntity(
            //     imageUrl,
            //     imageBuffer.size,
            //     imageBuffer.mimetype,
            //     imageFileName,

            // );


            // audioFile
            results.push({ audioFile, imageFile, duration });
        }
        return results;
    }
    async saveFile(
        file: Express.Multer.File,
        fileLocation = "",
    ): Promise<FileEntity> {

        if (fileLocation && fileLocation.length > 0) {
            if (fileLocation.startsWith('/'))
                fileLocation = fileLocation.substring(1);
            if (!fileLocation.endsWith('/'))
                fileLocation += '/';
        }

        const fileBuffer = file;
        const currentFileName = fileBuffer.originalname;
        const currentFileExt = fileBuffer.mimetype;
        const imageDestination = `${fileLocation}${currentFileName}`;

        const fileUrl = await this.uploadFile(fileBuffer.buffer, imageDestination, currentFileExt);




        const uploadedFile = new FileEntity();
        uploadedFile.url = fileUrl;
        uploadedFile.mimeType = fileBuffer.mimetype;
        uploadedFile.size = fileBuffer.size;
        uploadedFile.name = currentFileName;

        return uploadedFile;
    }

    async saveBufferAsFile(
        thumbnail: ThumbnailImageResponse,
        fileLocation = "",
        // originalFileBuffer?: Express.Multer.File,

    ): Promise<FileEntity> {

        if (fileLocation && fileLocation.length > 0) {
            if (fileLocation.startsWith('/'))
                fileLocation = fileLocation.substring(1);
            if (!fileLocation.endsWith('/'))
                fileLocation += '/';
        }

        const { name, ext, buffer, size } = thumbnail;

        const fileDestination = `${fileLocation}${ext}`;


        const fileUrl = await this.uploadFile(buffer!, fileDestination, ext);


        const uploadedFile = new FileEntity();
        uploadedFile.url = fileUrl;
        uploadedFile.mimeType = ext;
        uploadedFile.size = size ?? 0;
        uploadedFile.name = name;

        return uploadedFile;
    }
}

export const uploaderService: UploaderService = new UploaderService();
