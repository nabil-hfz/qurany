import mongoose from 'mongoose';
import { IBaseModel, BaseModelSchema } from '../../src/models/base-models';
import { MongoMemoryServer } from 'mongodb-memory-server';
import { beforeEach } from 'node:test';

// Define a mock model using the BaseModelSchema
const MockBaseModel = mongoose.model<IBaseModel>('MockBaseModel', BaseModelSchema);

describe('Base Model Tests', () => {
  let mongoServer: MongoMemoryServer;

  beforeAll(async () => {
    mongoServer = await MongoMemoryServer.create();
    await mongoose.connect(mongoServer.getUri());
  });

  beforeEach(async () => {
    await MockBaseModel.deleteMany({});
  });

  afterAll(async () => {
    await mongoose.disconnect();
    await mongoServer.stop();
  });
  
  it('should create a new BaseModel document with default values', async () => {
    const baseModel = await MockBaseModel.create({});

    expect(baseModel.createdAt).toBeDefined();
    expect(baseModel.updatedAt).toBeUndefined();
  });

  it('should update the updatedAt field when a BaseModel document is updated', async () => {
    const baseModel = await MockBaseModel.create({});

    // Simulate an update
    baseModel.updatedAt = new Date();
    await baseModel.save();

    const updatedBaseModel = await MockBaseModel.findById(baseModel._id);

    expect(updatedBaseModel?.updatedAt).toBeDefined();
  });

  it('should have a virtual id field', async () => {
    const baseModel = await MockBaseModel.create({});

    expect(baseModel.id).toBeDefined();
    expect(baseModel.id).toBe(baseModel._id.toHexString());
  });

  it('should serialize to JSON with virtuals', async () => {
    const baseModel = await MockBaseModel.create({});

    const serialized = baseModel.toJSON();

    expect(serialized.id).toBeDefined();
    expect(serialized.id).toBe(baseModel._id.toHexString());
  });

  it('should serialize to plain object with virtuals', async () => {
    const baseModel = await MockBaseModel.create({});

    const plainObject = baseModel.toObject();

    expect(plainObject.id).toBeDefined();
    expect(plainObject.id).toBe(baseModel._id.toHexString());
  });
});
