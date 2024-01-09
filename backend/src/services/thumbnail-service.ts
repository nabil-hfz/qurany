import { PDFDocument } from 'pdf-lib';
// import { createCanvas } from 'canvas';
// import { logError } from '../utils/logger';

export abstract class ThumbnailService {

    static async createPdfThumbnail(file: Express.Multer.File): Promise<any> {
        try {
            const pdfDoc = await PDFDocument.load(file.buffer);
            pdfDoc.toString();
            // const pdfPage = pdfDoc.getPage(0); // Get the first page

            // // Define the size of the thumbnail
            // const width = 200; // Width in pixels
            // const height = (pdfPage.getHeight() / pdfPage.getWidth()) * width;

            // // Create a canvas and render the PDF page onto it
            // const canvas = createCanvas(width, height);
            // const context = canvas.getContext('2d');
            // const pageImage = await pdfPage.renderToContext(context, {
            //     x: 0,
            //     y: 0,
            //     width,
            //     height,
            //     // You can adjust additional options if needed
            // });

            // Convert the canvas to a Buffer (PNG format)
            // return canvas.toBuffer('image/png');
        } catch (error) {
            console.error(error);
            throw error;
        }
    }

}


