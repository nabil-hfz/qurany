"use strict";
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
exports.Properties = exports.SubCollections = exports.AppRoutes = exports.statusLables = exports.AppFirebaseCollections = void 0;
class AppFirebaseCollections {
}
exports.AppFirebaseCollections = AppFirebaseCollections;
_a = AppFirebaseCollections;
AppFirebaseCollections.audiosStoragePath = "audios";
AppFirebaseCollections.imagesStoragePath = "images";
AppFirebaseCollections.filesImageCollection = "files_image";
AppFirebaseCollections.filesAudioCollection = "files_audio";
AppFirebaseCollections._audioKhatme = "/khatme";
AppFirebaseCollections._maherAlMueaqly = `${_a._audioKhatme}/maher_al_mueaqly`;
AppFirebaseCollections.maherAlMueaqly1 = `${_a._maherAlMueaqly}/1`;
AppFirebaseCollections._khaledAlabi = `${_a._audioKhatme}/khaled_alabi`;
AppFirebaseCollections.khaledAlabi1 = `${_a._khaledAlabi}/1`;
AppFirebaseCollections._abdulRahmanAlSudais = `${_a._audioKhatme}/abdul_rahman_al_sudais`;
AppFirebaseCollections.abdulRahmanAlSudais1 = `${_a._abdulRahmanAlSudais}/1`;
AppFirebaseCollections._abuBakrAlShatri = `${_a._audioKhatme}/abu_bakr_al_shatri`;
AppFirebaseCollections.abuBakrAlShatri1 = `${_a._abuBakrAlShatri}/1`;
exports.statusLables = [
    AppFirebaseCollections.maherAlMueaqly1,
    AppFirebaseCollections.khaledAlabi1,
    AppFirebaseCollections.abdulRahmanAlSudais1,
    AppFirebaseCollections.abuBakrAlShatri1,
];
class AppRoutes {
}
exports.AppRoutes = AppRoutes;
AppRoutes.khatmeRoute = "/khatma";
AppRoutes.recitersRoute = "/reciter";
AppRoutes.recitationsRoute = "/recitation";
var SubCollections;
(function (SubCollections) {
    SubCollections["users_evaluations"] = "usersEvaluations";
})(SubCollections = exports.SubCollections || (exports.SubCollections = {}));
var Properties;
(function (Properties) {
    Properties["evaluations"] = "evaluations";
})(Properties = exports.Properties || (exports.Properties = {}));
//# sourceMappingURL=collections.js.map