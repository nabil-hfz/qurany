"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.filesRepository = exports.FilesRepository = void 0;
const file_model_1 = require("../../models/file-model");
const repository_1 = require("../repository");
class FilesRepository extends repository_1.Repository {
    constructor(model) {
        super(model);
    }
}
exports.FilesRepository = FilesRepository;
exports.filesRepository = new FilesRepository(file_model_1.FileModel);
//# sourceMappingURL=files-repository.js.map