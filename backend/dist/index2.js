"use strict";
// import * as express from "express";
// import { Readable } from 'stream';
// import * as multer from 'multer';
// import { firebaseDep } from "./firebase/firebase-datasource";
// import * as ffprobe from 'ffprobe';
// import * as ffprobeStatic from 'ffprobe-static';
// import * as tmp from 'tmp';
// import * as fs from 'fs';
// const bucket = firebaseDep.storage().bucket();
// const app = express();
// const upload = multer();
// function bufferToStream(buffer: Buffer): Readable {
//   const stream = new Readable();
//   stream.push(buffer);
//   stream.push(null);
//   return stream;
// }
// async function getAudioDuration(buffer: Buffer): Promise<number> {
//   const tmpFile = tmp.fileSync();
//   fs.writeFileSync(tmpFile.name, buffer);
//   const metadata = await ffprobe(tmpFile.name, { path: ffprobeStatic.path });
//   tmpFile.removeCallback();
//   const audioStream = metadata.streams.find((stream) => stream.codec_type === 'audio');
//   return Math.round(audioStream?.duration??0);
// }
// async function uploadFile(
//   buffer: Buffer,
//   destination: string,
//   contentType: string
// ): Promise<string> {
//   const stream = bufferToStream(buffer);
//   const file = bucket.file(destination);
//   return new Promise((resolve, reject) => {
//     stream.pipe(
//       file.createWriteStream({
//         metadata: {
//           contentType,
//         },
//       })
//     )
//     .on('error', reject)
//     .on('finish', () => {
//       file.getSignedUrl(
//         {
//           action: 'read',
//           expires: '03-09-2491',
//         },
//         (err, url) => {
//           if (err) reject(err);
//           resolve(url as string);
//         }
//       );
//     });
//   });
// }
// async function handleFiles(
//   images: Express.Multer.File[],
//   audios: Express.Multer.File[]
// ): Promise<Array<{ audioUrl: string; imageUrl: string; duration: number }>> {
//   const results = [];
//   for (let i = 0; i < audios.length; i++) {
//     const audioBuffer = audios[i].buffer;
//     const imageBuffer = images[i].buffer;
//     const audioDestination = `audios2/Audio${i + 1}.mp3`;
//     const imageDestination = `images2/Slide${i + 1}.png`; // replace with the correct image extension
//     const audioUrl = await uploadFile(audioBuffer, audioDestination, 'audio/mpeg');
//     const imageUrl = await uploadFile(imageBuffer, imageDestination, 'image/png'); // change 'image/png' based on the actual image format
//     const duration = await getAudioDuration(audioBuffer);
//     results.push({ audioUrl, imageUrl, duration });
//   }
//   return results;
// }
// app.post(
//   '/upload',
//   upload.fields([{ name: 'audios' }, { name: 'images' }]),
//   async (req: any, res: any) => {
//     try {
//       const audios = req.files['audios'] as Express.Multer.File[];
//       const images = req.files['images'] as Express.Multer.File[];
//       const result = await handleFiles(images, audios);
//       res.json(result);
//     } catch (error) {
//       console.error('Error:', error);
//       res.status(500).send('Error processing files.');
//     }
//   }
// );
// const PORT = process.env.PORT || 3000;
// app.listen(PORT, () => {
//   console.log(`Server is running on port ${PORT}`);
// });
//# sourceMappingURL=index2.js.map