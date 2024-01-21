
export interface ThumbnailImageResponse {
    size?: number;
    page?: number;
    buffer?: Buffer;
    name?: string;
    ext?: string;
}

import { fromBuffer } from "pdf2pic";

import * as path from 'path';
import * as fs from 'fs';


export class ThumbnailService {
    static async createPdfThumbnail(file: Express.Multer.File): Promise<ThumbnailImageResponse> {
        try {

            const originalname = file.originalname;

            const fileBuffer = file.buffer;
            const { name, ext } = path.parse(originalname);

            // console.log(`Original filename: ${originalname}, Name: ${name}, Extension: ${ext}`);

            const directory = path.dirname(__filename);
            
            // console.log(`Saving thumbnails to directory: ${directory}`);
            const tempLocation = path.join(directory, originalname);
            fs.writeFileSync(tempLocation, fileBuffer);

            const options = {
                preserveAspectRatio: true,
                format: 'png',
                saveFilename: name,
                savePath: directory,
            };

            // console.log(`Thumbnail creation options: ${JSON.stringify(options)}`);

            const convert = fromBuffer(fileBuffer, options);
            const pageToConvertAsImage = 1;

            const result = await convert(pageToConvertAsImage, { responseType: "buffer" });

            const thumbnail = {
                buffer: result.buffer,
                size: Buffer.byteLength(result.buffer!),
                page: result.page,
                name: name,
                ext: ext,
            };
            // const { buffer, ...rest } = thumbnail;
            // console.log(`Thumbnail details: ${JSON.stringify(rest)}`);
            return thumbnail;

        } catch (error: any) {
            console.error('Error creating thumbnail:', error.message);
            console.error('Stack Trace:', error.stack);
            throw error;
        }
    }
}


