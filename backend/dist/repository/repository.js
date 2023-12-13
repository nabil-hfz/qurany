"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Repository = void 0;
const logger_1 = require("../utils/logger");
class Repository {
    constructor(model) {
        this.model = model;
    }
    async getAll(conditions, page = 1, size = 20, projection, sortOptions) {
        const options = {
            page: page,
            limit: size,
            sort: sortOptions
        };
        const result = await this.model
            .find(conditions, projection, options)
            .exec();
        let answer = { items: result };
        //  Checks if getAll true, then returns all documents with count.
        if (conditions.getAll) {
            const totalDocs = await this.model.countDocuments(conditions);
            answer.totalDocs = totalDocs;
            answer.totalPages = Math.ceil(totalDocs / size);
        }
        return answer;
    }
    async createAll(resources) {
        try {
            return await this.model.insertMany(resources);
        }
        catch (error) {
            (0, logger_1.logError)(error);
            return null;
        }
    }
    async getOneById(id) {
        try {
            return await this.model.findById(id).exec();
        }
        catch (error) {
            (0, logger_1.logError)(error);
            return null;
        }
    }
    async create(resource) {
        const document = new this.model(resource);
        let result = await document.save();
        return result;
    }
    async update(id, resource) {
        return await this.model.findByIdAndUpdate(id, resource, { new: true }).exec();
    }
    async delete(id) {
        let result = await this.model.findByIdAndDelete(id).exec();
        return result.value;
    }
}
exports.Repository = Repository;
//# sourceMappingURL=repository.js.map