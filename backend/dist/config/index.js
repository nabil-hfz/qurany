"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.currentEnv = void 0;
const path = require("path");
const dotenv = require("dotenv");
exports.currentEnv = process.env.NODE_ENV;
function init() {
    const projectName = exports.currentEnv;
    let envPath;
    switch (projectName) {
        case "dev":
            envPath = path.resolve(process.cwd(), "./src/environment/.env.dev");
            break;
        case "prod":
            envPath = path.resolve(process.cwd(), "./src/environment/.env.prod");
            break;
        default:
            throw new Error("Application not supported");
    }
    dotenv.config({ path: envPath, debug: true, override: true });
    console.log(`process env ${exports.currentEnv}`);
}
exports.default = init;
//# sourceMappingURL=index.js.map