import { EntityTarget, ObjectId, Repository as TypeORMRepository, } from 'typeorm';
import { Repository } from '../../src/repository/repository';
import { AppBaseEntity } from '../../src/db/entities/base.entity';
// Mock entity class for testing
class MockEntity extends AppBaseEntity {
    name?: string;
    MockEntity() {

    }
}
class RepositoryImpl<T extends AppBaseEntity> extends Repository<T> {
    constructor(entity: EntityTarget<T>) {
        super(entity);
    }

    get repository(): TypeORMRepository<T> {
        return this._repository;
    }
}

jest.mock('typeorm', () => {
    const actualTypeorm = jest.requireActual('typeorm');
    return {
        ...actualTypeorm,
        getRepository: jest.fn().mockReturnValue({
            findAndCount: jest.fn(),
            update: jest.fn(),
            findOne: jest.fn(),
        }),
    };
});



describe('Repository', () => {
    let repository: RepositoryImpl<MockEntity>;
    let mockUpdate: jest.Mock;

    beforeEach(() => {
        // Mock the TypeORM repository methods used in your Repository class
        repository = new RepositoryImpl(MockEntity); // Replace 'YourEntity' with your actual entity class
        mockUpdate = jest.fn();
        // repository['_repository'].update = mockUpdate;
    });



    beforeEach(() => {
        // Use the mock entity class for testing
        repository = new RepositoryImpl(MockEntity);
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    describe('getAll', () => {
        it('should return items and pagination details', async () => {
            const mockItems = [{ id: 1 }, { id: 2 }]; // replace with actual mock data
            const mockTotal = 10;
            const mockFindAndCount = jest.fn().mockResolvedValue([mockItems, mockTotal]);


            repository.repository.findAndCount = mockFindAndCount;

            const options: any = {
                conditions: { page: 1, limit: 2 },
                order: { id: 'ASC' },
            };


            const result = await repository.getAll(options);

            expect(mockFindAndCount).toHaveBeenCalledWith({
                where: {},
                skip: 0,
                take: 2,
                order: { id: 'ASC' },
                relations: undefined,
            });
            expect(result.items).toEqual(mockItems);
            expect(result.totalDocs).toEqual(mockTotal);
            expect(result.totalPages).toEqual(5);
        });

        it('should handle errors gracefully', async () => {
            repository.repository.findAndCount = jest.fn().mockRejectedValue(new Error('Test error'));

            const result = await repository.getAll();

            expect(result.items).toEqual([]);
            expect(result.totalDocs).toEqual(0);
            expect(result.totalPages).toEqual(0);
        });


    });

    describe('createAll', () => {
        it('should successfully create all resources', async () => {
            const mockEntities = [{ id: 1, name: 'Entity1' }, { id: 2, name: 'Entity2' }];
            repository.repository.save = jest.fn().mockResolvedValue(mockEntities);

            const result = await repository.createAll(mockEntities as any);

            expect(repository.repository.save).toHaveBeenCalledWith(mockEntities);
            expect(result).toEqual(mockEntities);
        });

        it('should return null on error', async () => {
            repository.repository.save = jest.fn().mockRejectedValue(new Error('Test error'));

            const result = await repository.createAll([{ id: 3, name: 'Entity3' }] as any);

            expect(repository.repository.save).toHaveBeenCalled();
            expect(result).toBeNull();
        });
    });

    describe('update', () => {
        it('should update a resource successfully', async () => {
            const id = 1;
            const resource = { /* your resource data */ };
            const updatedResource = { ...resource, id };

            mockUpdate.mockResolvedValue({ raw: updatedResource });

            const result = await repository.update(id, resource);

            expect(mockUpdate).toHaveBeenCalledWith(expect.any(ObjectId), resource);
            expect(result).toEqual(updatedResource);
        });

        // it('should return null if the update operation fails', async () => {
        //     const id = 1;
        //     const resource = { /* your resource data */ };

        //     mockUpdate.mockRejectedValue(new Error('Update failed'));

        //     const result = await repository.update(id, resource);

        //     expect(mockUpdate).toHaveBeenCalledWith(expect.any(ObjectId), resource);
        //     expect(result).toBeNull();
        // });
    });
    // describe('update', () => {
    //     const mockId = 1;
    //     const mockUpdateData = new MockEntity();

    //     mockUpdateData.name = 'Updated Entity';
    //     const mockUpdatedEntity = new MockEntity();
    //     mockUpdatedEntity.id = mockId;
    //     mockUpdatedEntity.name = mockUpdateData.name;


    //     it('should successfully update a resource', async () => {
    //         repository.repository.update.mockResolvedValue({ affected: 1 });
    //         mockRepository.findOne.mockResolvedValue(updatedEntity);

    //         const result = await repository.update(id, resource);
    //         expect(result).toEqual(updatedEntity);
    //         expect(mockRepository.update).toHaveBeenCalledWith(id, resource);
    //         expect(mockRepository.findOne).toHaveBeenCalledWith(id);
    //         // Mock the TypeORM update method to simulate a successful update
    //         // repository.repository.update = jest.fn().mockResolvedValue({ affected: 1 });

    //         // const result = await repository.update(mockId, mockUpdateData);

    //         // expect(repository.repository.update).toHaveBeenCalledWith(mockId, mockUpdateData);
    //         // expect(result).not.toBeNull();  // Assuming the update method returns some value on success
    //         // repository.repository.update = jest.fn().mockResolvedValue({ affected: 1 });
    //         // repository.repository.findOne = jest.fn().mockResolvedValue(mockUpdatedEntity);

    //         // const result = await repository.update(mockId, mockUpdateData);
    //         // console.log('result ', result);
    //         // expect(repository.repository.update).toHaveBeenCalledWith(mockId, mockUpdateData);
    //         // expect(repository.repository.findOne).toHaveBeenCalledWith({ where: { id: mockId } });
    //         // expect(result).toEqual(mockUpdatedEntity);
    //     });

    //     // it('should return null when resource does not exist', async () => {
    //     //     repository.repository.update = jest.fn().mockResolvedValue({ affected: 0 });
    //     //     repository.repository.findOne = jest.fn();

    //     //     const result = await repository.update(mockId, mockUpdateData);

    //     //     expect(repository.repository.update).toHaveBeenCalledWith(new ObjectId(mockId), mockUpdateData);
    //     //     expect(repository.repository.findOne).not.toHaveBeenCalled();
    //     //     expect(result).toBeNull();
    //     // });

    //     // it('should return null on error', async () => {
    //     //     repository.repository.update = jest.fn().mockRejectedValue(new Error('Test error'));

    //     //     const result = await repository.update(mockId, mockUpdateData);

    //     //     expect(repository.repository.update).toHaveBeenCalled();
    //     //     expect(result).toBeNull();
    //     // });
    // });
});
