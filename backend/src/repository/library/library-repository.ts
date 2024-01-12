import { UploaderService, uploaderService } from './../../services/uploader-service';
import { FileEntryEntity } from '../../db/entities/file-entiry.entity';
import { Repository } from "../repository";
import { HttpResponseError } from "../../utils/http-response-error";
import { EntityTarget } from "typeorm";
import { AppPagination } from "../../middlewares/pagination.middleware";
import { CreateFileEntryReqBody } from '../../controllers/library-controller/requests/create-file-entry/create-file-entry-req-body';
import { CategoryRepository, categoryRepository } from './category-repository';
import { LanguageRepository, languageRepository } from './language-repository';
import { CategoryEntity } from '../../db/entities/category.entity';
import { AppStoragePathsConst } from '../../constant/app-storage-paths.const';
import { ThumbnailService } from '../../services/thumbnail-service';
import { FilesRepository, filesRepository } from '../file/files-repository';

export class LibraryRepository extends Repository<FileEntryEntity> {

    constructor(
        model: EntityTarget<FileEntryEntity>,
        private uploaderService: UploaderService,
        private categoryRepository: CategoryRepository,
        private languageRepository: LanguageRepository,
        private filesRepository: FilesRepository,
    ) {
        super(model);
    }

    async createFileEntry(
        request: CreateFileEntryReqBody,
        file: Express.Multer.File,
    ): Promise<any> {

        const languageId = request.languageId;
        const language = await this.languageRepository.getLanguageById(languageId!);
        if (!language)
            throw new HttpResponseError(400, "BAD_REQUEST", 'No language found with this id ' + languageId);

        const categories: CategoryEntity[] = [];
        for (let id of request.categoryIds ?? []) {
            const category = await this.categoryRepository.getOneById(id);
            if (!category)
                throw new HttpResponseError(400, "BAD_REQUEST", 'No category found with this id ' + id);
            categories.push(category);
        }

        const filePath = AppStoragePathsConst.libraryFileEntry + `/language_${languageId}`;
        const uploadedFileResult = await this.uploaderService
            .saveFile(file, filePath);

        if (!uploadedFileResult) {
            throw new HttpResponseError(400, "BAD_REQUEST", 'No file found "uploadedFileResult" is null');
        }
        const savedFileResult = await this.filesRepository.create(uploadedFileResult);


        const thumbnailFilePath = await ThumbnailService.createPdfThumbnail(file);
        if (!thumbnailFilePath) {
            throw new HttpResponseError(400, "BAD_REQUEST", 'No file found "bufferThumbnail" is null');
        }

        const thumbnailPath = AppStoragePathsConst.libraryThumbnail + `/language_${languageId}`;
        const uploadedThumbnailResult = await this.uploaderService
            .saveBufferAsFile(thumbnailFilePath, thumbnailPath);
        if (!uploadedThumbnailResult) {
            throw new HttpResponseError(400, "BAD_REQUEST", 'No file found "thumbnailResult" is null');
        }
        const savedThumbnailResult = await this.filesRepository.create(uploadedThumbnailResult);


        const entity = new FileEntryEntity();
        entity.name = request.name!;
        entity.description = request?.description;
        entity.language = language!;
        entity.categories = categories;
        entity.file = savedFileResult;
        entity.thumbnail = savedThumbnailResult;

        const result = await this._repository.save(entity);

        return result;
    }



    async getFileEntrys(
        languageId?: number | undefined,
        categories?: number[] | undefined,
        name?: string | undefined,
        pagination?: AppPagination,

    ) {
        let options: any = {};

        if (languageId) {
            options.languageId = languageId;
        }
        if (name) {
            options.name = name;
        }

        if (categories && categories.length > 0) {
            options.categories = categories;
        }

        return await this.getAll(
            {
                conditions: {
                    ...options,
                    ...pagination
                },
                relations: {
                    language: true,
                    file: true,
                    thumbnail: true,
                }
            }

        );
    }

    async getFileEntryById(id: number): Promise<FileEntryEntity | null> {
        const resource = await this.getOneById(id);
        return resource;
    }
}

export const libraryRepository = new LibraryRepository(
    FileEntryEntity,
    uploaderService,
    categoryRepository,
    languageRepository,
    filesRepository,
);
