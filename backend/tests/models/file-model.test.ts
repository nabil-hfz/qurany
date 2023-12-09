// // fileModel.test.ts

// import mongoose from 'mongoose';
// import { MongoMemoryServer } from 'mongodb-memory-server';
// import { FileModel, IFileModel } from '../../src/models/file-model';


// describe('FileModel Tests', () => {
//   let mongoServer: MongoMemoryServer;

//   beforeAll(async () => {
//     mongoServer = await MongoMemoryServer.create();
//     await mongoose.connect(mongoServer.getUri());
//   });

//   beforeEach(async () => {
//   });

//   afterAll(async () => {
//     await mongoose.disconnect();
//     await mongoServer.stop();
//   });

//   it('should create a file document', async () => {
//     const fileData: Partial<IFileModel> = {
//       url: 'http://example.com/file.jpg',
//       size: 1024,
//       mimetype: 'image/jpeg',
//       name: 'file.jpg'
//     };

//     const file = new FileModel(fileData);
//     const savedFile = await file.save();

//     expect(savedFile.url).toBe(fileData.url);
//     expect(savedFile.size).toBe(fileData.size);
//     expect(savedFile.mimetype).toBe(fileData.mimetype);
//     expect(savedFile.name).toBe(fileData.name);
//   });


//   it('should require url field', async () => {
//     const fileData = { mimetype: 'image/jpeg', name: 'file.jpg' };

//     try {
//       await new FileModel(fileData as IFileModel).save();
//     } catch (error: any) {
//       // console.error(error.errors)
//       expect(error).toBeInstanceOf(mongoose.Error.ValidationError);
//       expect(error.errors?.url).toBeDefined();
//     }
//   });


//   it('should require size field', async () => {
//     const fileData = {
//       url: 'http://example.com/file.jpg',
//       mimetype: 'image/jpeg', name: 'file.jpg'
//     };

//     try {
//       await new FileModel(fileData as IFileModel).save();
//     } catch (error: any) {
//       // console.error(error.errors)
//       expect(error).toBeInstanceOf(mongoose.Error.ValidationError);
//       expect(error.errors?.size).toBeDefined();
//     }
//   });

//   it('should allow undefined values for mimetype and name', async () => {
//     const fileData = {
//       url: 'https://example.com/file.txt',
//       size: 1024,
//     };

//     const file = await FileModel.create(fileData);

//     expect(file.mimetype).toBeUndefined();
//     expect(file.name).toBeUndefined();
//   });

// });

