import { fromBuffer } from "pdf2pic";

// import * as fs from 'fs';
import * as path from 'path';
export class ThumbnailService {
    static async createPdfThumbnail(file: Express.Multer.File): Promise<ThumbnailImageResponse> {
        try {

            const buffer = file.buffer;

            // Define the file name
            const originalname = file.originalname;
            const { name, ext } = path.parse(originalname);

            const directory = path.dirname(__filename);

            const options = {
                preserveAspectRatio: true,
                format: 'png',
                saveFilename: name,
                savePath: directory,

            };
            const convert = fromBuffer(buffer, options);
            const pageToConvertAsImage = 1;

            const result = await convert(pageToConvertAsImage, { responseType: "buffer" });

            return {
                buffer: result.buffer,
                size: Buffer.byteLength(result.buffer!),
                page: result.page,
                name: name,
                ext: ext,
            };

        } catch (error) {
            console.error('Error creating thumbnail:', error);
            throw error;
        }
    }
}


export interface ThumbnailImageResponse {
    size?: number;
    page?: number;
    name?: string;
    ext?: string;
    buffer?: Buffer;
}


