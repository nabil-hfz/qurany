export abstract class AppFirebaseCollections {

  
  static audiosStoragePath = "audios";
  static imagesStoragePath = "images";

  static filesImageCollection = "files_image";
  static filesAudioCollection = "files_audio";


  private static _audioKhatme = "/khatme";

  private static _maherAlMueaqly = `${this._audioKhatme}/maher_al_mueaqly`;
  static maherAlMueaqly1 = `${this._maherAlMueaqly}/1`;


  private static _khaledAlabi = `${this._audioKhatme}/khaled_alabi`;
  static khaledAlabi1 = `${this._khaledAlabi}/1`;


  private static _abdulRahmanAlSudais = `${this._audioKhatme}/abdul_rahman_al_sudais`;
  static abdulRahmanAlSudais1 = `${this._abdulRahmanAlSudais}/1`;


  private static _abuBakrAlShatri = `${this._audioKhatme}/abu_bakr_al_shatri`;
  static abuBakrAlShatri1 = `${this._abuBakrAlShatri}/1`;

}

export const statusLables = [
  AppFirebaseCollections.maherAlMueaqly1,
  AppFirebaseCollections.khaledAlabi1,
  AppFirebaseCollections.abdulRahmanAlSudais1,
  AppFirebaseCollections.abuBakrAlShatri1,
];

export abstract class AppRoutes {
  static khatmeRoute = "/khatma";
  static recitersRoute = "/reciter";
  static recitationsRoute = "/recitation";
}

export enum SubCollections {
  users_evaluations = "usersEvaluations",
}

export enum Properties {
  evaluations = "evaluations",
}
