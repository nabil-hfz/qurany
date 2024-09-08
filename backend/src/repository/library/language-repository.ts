import { Repository } from "../repository";
import { EntityTarget } from "typeorm";
import { AppPagination } from "../../middlewares/pagination.middleware";
import { LanguageEntity } from '../../db/entities/language.entity';
import { CreateLanguagesReqBody } from "../../controllers/library-language-controller/requests/create-language/create-language-req-body";

export class LanguageRepository extends Repository<LanguageEntity> {

    constructor(
        model: EntityTarget<LanguageEntity>,
    ) {
        super(model);
    }

    async createLanguages(languages: CreateLanguagesReqBody): Promise<any> {
        const entities: LanguageEntity[] = languages.languages.map((lang) => {
            const entity = new LanguageEntity();
            entity.name = lang.name;
            entity.language_code = lang.language_code;
            return entity;

        }) ?? [];
        const result = await this._repository.save(entities);
        return result as LanguageEntity[];
    }

    async getLanguageById(id: number): Promise<LanguageEntity | null> {
        const resource = await this.getOneById(id);
        if (!resource || !resource?.id) {
            return null;
        }

        return resource;
    }

    async getLanguages(
        pagination?: AppPagination
    ) {
        return await this.getAll(
            {
                conditions: {
                    ...pagination
                }
            }

        );
    }
}

export const languageRepository = new LanguageRepository(
    LanguageEntity,
);
