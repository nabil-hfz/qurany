import { AppConst } from "./app.const";

export abstract class AppRoutes {
    static khatmeRoute = `${AppConst.AppFunctionVersion1}/khatma`;
    static recitersRoute = `${AppConst.AppFunctionVersion1}/reciter`;
    static recitationsRoute = `${AppConst.AppFunctionVersion1}/recitation`;
    static rootRoute = `/home`;
}
