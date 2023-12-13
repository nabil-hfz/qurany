"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CONTROLLERS = void 0;
const root_controller_1 = require("./root-controller");
const reciter_controller_1 = require("./reciter-controller/reciter-controller");
const account_controller_1 = require("./account-controller/account-controller");
const khatma_controller_1 = require("./khatma-controller/khatma-controller");
const recitation_controller_1 = require("./recitation-controller/recitation-controller");
/** TODO: Set yours controllers here: */
exports.CONTROLLERS = [
    new root_controller_1.RootController(),
    new reciter_controller_1.ReciterController(),
    new account_controller_1.AccountController(),
    new khatma_controller_1.KhatmaController(),
    new recitation_controller_1.RecitationController(),
];
//# sourceMappingURL=controllers.js.map