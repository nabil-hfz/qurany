"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RootController = void 0;
const app_const_1 = require("../../constant/app.const");
let counter = 1;
class RootController {
    constructor() {
        this.rootPath = "/home";
        this.root = async (req, res, next) => {
            res.send({
                status: `API is working! Counter: ${counter++}`,
            });
            next();
        };
    }
    initialize(httpServer) {
        const url = `${app_const_1.AppConst.AppFunctionVersion1}${this.rootPath}`;
        // httpServer.get(url, this.root.bind(this));
        httpServer.get({ path: `${url}`, requestHandler: this.root.bind(this) });
        // httpServer.get({ path: `${url}hello-world`, requestHandler: this.root.bind(this) });
    }
}
exports.RootController = RootController;
//# sourceMappingURL=index.js.map