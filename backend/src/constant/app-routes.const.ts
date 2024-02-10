import { AppConst } from "./app.const";

export abstract class AppRoutes {
    static rootRoute = `/home`;
    static healthRoute = `${AppConst.AppFunctionVersion1}/health`;
    static accountRoute = `${AppConst.AppFunctionVersion1}/account`;
    static khatmeRoute = `${AppConst.AppFunctionVersion1}/khatma`;
    static recitersRoute = `${AppConst.AppFunctionVersion1}/reciter`;
    static recitationsRoute = `${AppConst.AppFunctionVersion1}/recitation`;
    static libraryRoute = `${AppConst.AppFunctionVersion1}/library`;
    static categoryRoute = `${AppConst.AppFunctionVersion1}/library/category`;
    static languageRoute = `${AppConst.AppFunctionVersion1}/library/language`;
}
