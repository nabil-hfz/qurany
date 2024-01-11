import { AppConst } from "./app.const";

export abstract class AppRoutes {
    static healthRoute = `${AppConst.AppFunctionVersion1}/health`;
    static khatmeRoute = `${AppConst.AppFunctionVersion1}/khatma`;
    static recitersRoute = `${AppConst.AppFunctionVersion1}/reciter`;
    static recitationsRoute = `${AppConst.AppFunctionVersion1}/recitation`;
    static libraryRoute = `${AppConst.AppFunctionVersion1}/library`;
    static categoryRoute = `${AppConst.AppFunctionVersion1}/library/category`;
    static languageRoute = `${AppConst.AppFunctionVersion1}/library/language`;
    static rootRoute = `/home`;
}
