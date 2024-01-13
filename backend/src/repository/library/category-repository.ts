import { Repository } from "../repository";
import { EntityTarget } from "typeorm";
import { AppPagination } from "../../middlewares/pagination.middleware";
import { CategoryEntity } from "../../db/entities/category.entity";
import { LocalizedEntity } from "../../db/entities/localized.entity";
import { CreateCategoriesReqBody } from "../../controllers/library-category-controller/requests/create-category/create-category-req-body";

export class CategoryRepository extends Repository<CategoryEntity> {

    constructor(
        model: EntityTarget<CategoryEntity>,
    ) {
        super(model);
    }

    async createCategories(
        request: CreateCategoriesReqBody,
    ): Promise<any> {
        const entities: CategoryEntity[] = request.categories.map((data) => {
            const entity = new CategoryEntity();
            const localized = new LocalizedEntity();
            localized.ar = data.ar;
            localized.en = data.en;
            entity.name = localized;
            return entity;

        }) ?? [];
        const result = await this._repository.save(entities);
        return result as CategoryEntity[];
    }

    async getCategoryById(id: number): Promise<CategoryEntity | null> {
        const recource = await this.getOneById(id);
        return recource;
    }

    async getCategories(
        pagination?: AppPagination
    ) {


        return await this.getAll(
            {
                conditions: {
                    ...pagination
                },
                // relations: {
                //     // fileEntries: true,
                // }
            }

        );
    }
}

export const categoryRepository = new CategoryRepository(
    CategoryEntity,

);
