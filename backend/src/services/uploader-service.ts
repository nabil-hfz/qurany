
import { Readable } from "node:stream";
import { CreateWriteStreamOptions } from "@google-cloud/storage";
import { v4 as uuidv4 } from 'uuid';
import { firebaseDep } from '../firebase/firebase-datasource';
// import { logError, logInfo } from '../utils/logger';
// import { FileInfo } from 'busboy';
// import * as busboy from 'busboy';
// type GetSignedUrlConfig = any;
// import { once } from 'events';

// import { tmpdir } from 'os';
// import { join } from 'path';
// import path = require('path');
import * as fs from 'fs';
import * as ffprobe from 'ffprobe';
import * as ffprobeStatic from 'ffprobe-static';
import * as tmp from 'tmp';
import { FileEntity } from "../db/entities/file.entity";



class UploaderService {
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
        const durtion = Math.round(Number(audioStream?.duration) ?? 0);

        // Clean up temp file
        fs.unlinkSync(tmpFile.name);
        tmpFile.removeCallback();

        return durtion;
    }

    async uploadFile(
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


        // const uploadedFile = new FileModel({
        //     url: fileUrl,
        //     mimetype: fileBuffer.mimetype,
        //     size: fileBuffer.size,
        //     name: currentFileName,
        // });


        return uploadedFile;
    }

    // async uploadFiles(
    //     req: any,
    //     res: any,
    //     next: any,
    //     fileLocation: string = "",
    // ): Promise<{ url: string; duration: number }[]> {
    //     logInfo('UploaderService is triggering uploadFile func')

    //     try {
    //         if (fileLocation && fileLocation.length > 0 && !fileLocation.endsWith('/')) fileLocation += '/';

    //         const fileUploadPromises: Promise<{ url: string; duration: number }>[] = [];

    //         const bb = busboy({ headers: req.headers });

    //         bb.on(this._onFileEvent, (fieldname: string, file: Readable, fileInfo: FileInfo) => {
    //             const fileUploadPromise = new Promise<{ url: string; duration: number }>(async (resolve, reject) => {
    //                 const tmpFilePath = join(tmpdir(), fileInfo.filename);

    //                 // Save the file to a temporary location
    //                 const writeStream = fs.createWriteStream(tmpFilePath);
    //                 file.pipe(writeStream);


    //                 writeStream.on(this._onErrorEvent, (error) => {
    //                     // Handle errors during file writing
    //                     reject(error);
    //                 });
    //                 // Wait for the file to be written to disk
    //                 await once(writeStream, this._onFinishEvent);

    //                 // Get the duration of the audio file
    //                 const duration = await this.getAudioDuration(tmpFilePath);

    //                 // Upload the file to Google Cloud Storage
    //                 const storage = firebaseDep.storage();
    //                 const bucket = storage.bucket();
    //                 const newBucketFile = bucket.file(`${fileLocation}${fileInfo.filename}`);
    //                 // const fileExtension = path.extname(tmpFilePath); 
    //                 // Upload the file from the temporary location to Google Cloud Storage
    //                 logInfo(`uploadFile func fileInfo:${JSON.stringify(fileInfo)} and fieldname: ${JSON.stringify(fieldname)}`)
    //                 const options: CreateWriteStreamOptions = {
    //                     gzip: true,
    //                     public: true,
    //                     resumable: true,
    //                     timeout: 1000 * 60 * 10,
    //                     // contentType: fileExtension,
    //                     metadata: {
    //                         // contentType: fileExtension,
    //                         metadata: {
    //                             firebaseStorageDownloadTokens: uuidv4(),
    //                         },

    //                     }
    //                 };
    //                 const readStream = fs.createReadStream(tmpFilePath);
    //                 readStream.pipe(newBucketFile.createWriteStream(options));


    //                 readStream.on(this._onErrorEvent, (error) => {
    //                     // Handle errors during file writing
    //                     reject(error);
    //                 });
    //                 // Wait for the upload to finish
    //                 await once(readStream, this._onEndEvent);

    //                 // Delete the temporary file
    //                 fs.unlinkSync(tmpFilePath);

    //                 const publicUrl = newBucketFile.publicUrl();
    //                 resolve({ url: publicUrl, duration });
    //             });

    //             fileUploadPromises.push(fileUploadPromise);
    //         });


    //         const ans: any = req.rawBody;
    //         bb.end(ans);

    //         // Wait for all the file upload promises to resolve
    //         const fileUrlsAndDurations = await Promise.all(fileUploadPromises);

    //         return fileUrlsAndDurations;

    //         // bb.on(this._onFileEvent, (fieldname: string, file: Readable, fileInfo: FileInfo) => {

    //         //     // Create a bucket associated to Firebase storage bucket
    //         //     const storage = firebaseDep.storage();
    //         //     const bucket = storage.bucket(process.env.GCLOUD_STORAGE_BUCKET_URL);
    //         //     const newBucketFile = bucket.file(`${fileLocation}${fileInfo.filename}`);

    //         //     // fileInfo is { filename: 'Audio5.mp3', encoding: '7bit', mimeType: 'audio/mpeg' }

    //         //     logInfo(`uploadFile func fileInfo:${JSON.stringify(fileInfo)} and fieldname: ${JSON.stringify(fieldname)}`)
    //         //     const options: CreateWriteStreamOptions = {
    //         //         gzip: true,
    //         //         public: true,
    //         //         resumable: false,
    //         //         // contentType: fileInfo.mimeType,
    //         //         metadata: {
    //         //             contentType: fileInfo.mimeType,
    //         //             metadata: {
    //         //                 firebaseStorageDownloadTokens: uuidv4(),
    //         //             },

    //         //         }
    //         //     };
    //         //     // Wrap the file upload process in a promise and push it to the array
    //         //     const fileUploadPromise = new Promise<string>(async (resolve, reject) => {
    //         //         //I don't write a temp file on disk, I directly upload it
    //         //         file.pipe(newBucketFile.createWriteStream(options))
    //         //             .on(this._onErrorEvent, function (error: Error) {
    //         //                 logError(`uploadFile func error happened when reading the file from the buffer in busboy: ${error}`)
    //         //                 next(error)
    //         //             })
    //         //             .on(this._onFinishEvent, async function () {
    //         //                 logInfo(`uploadFile func file uploaded successfully.`);
    //         //                 const publicUrl = newBucketFile.publicUrl();
    //         //                 logInfo(`uploadFile func publicUrl: ` + publicUrl);

    //         //                 // const signedUrlOptions: GetSignedUrlConfig = {
    //         //                 //     action: 'read',
    //         //                 //     expires: '03-01-2050',
    //         //                 // };
    //         //                 // const signedUrl = await newBucketFile.getSignedUrl(signedUrlOptions);
    //         //                 // logInfo(`uploadFile func signedUrl: ` + signedUrl);
    //         //                 // res.send();
    //         //                 // return publicUrl;
    //         //                 resolve(publicUrl);

    //         //             });

    //         //     });

    //         //     fileUploadPromises.push(fileUploadPromise);

    //         // });
    //         // // Triggered once all uploaded files are processed by Busboy.
    //         // // We still need to wait for the disk writes (saves) to complete.
    //         // // bb.on(this.onFinishEvent, async () => {
    //         // //     res.send();
    //         // // });
    //         // // console.log("done header ", req.headers);
    //         // logInfo("uploadFile func  req body length " + req.body.length);
    //         // logInfo("uploadFile func  req rawBody length " + req.rawBody.length);

    //         // const ans: any = req.rawBody;
    //         // bb.end(ans);
    //         // // Wait for all the file upload promises to resolve
    //         // const fileUrls = await Promise.all(fileUploadPromises);

    //         // return fileUrls;
    //         // return url;
    //     } catch (error) {
    //         logError(`uploadFile func error happened: ${error}`)
    //         next(error)
    //         return [];
    //     }

    // }


}

export const uploaderService: UploaderService = new UploaderService();
