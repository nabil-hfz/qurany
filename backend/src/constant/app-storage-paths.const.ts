
export abstract class AppStoragePathsConst {


  static audiosPath = "audios";
  static imagesPath = "images";
  static imagesUserPath = `${AppStoragePathsConst.imagesPath}/users`;
  private static libraryPath = "library";

  static filesImageCollection = "files_image";
  static filesAudioCollection = "files_audio";


  private static _audioKhatme = "khatme";
  private static _imageReciters = "reciters";

  // Reciteration images
  static maherAlMueaqly = `${this._audioKhatme}/maher_al_mueaqly`;
  static khaledAlabi = `${this._audioKhatme}/khaled_alabi`;
  static abdulRahmanAlSudais = `${this._audioKhatme}/abdul_rahman_al_sudais`;
  static abuBakrAlShatri = `${this._audioKhatme}/abu_bakr_al_shatri`;


  // Reciters images
  static maherAlMueaqlyImages = `${this._imageReciters}/maher_al_mueaqly`;
  static khaledAlabiImages = `${this._imageReciters}/khaled_alabi`;
  static abdulRahmanAlSudaisImages = `${this._imageReciters}/abdul_rahman_al_sudais`;
  static abuBakrAlShatriImages = `${this._imageReciters}/abu_bakr_al_shatri`;

  // Library paths
  static libraryFileEntry = `${this.libraryPath}/file_entry`;
  static libraryThumbnail = `${this.libraryPath}/thumbnail`;

}




export const AppImagesKhatmeConst: { [key: number]: string } = {
  1: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.maherAlMueaqly}`,
  2: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.khaledAlabi}`,
  3: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.abdulRahmanAlSudais}`,
  4: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.abuBakrAlShatri}`,
}

export const AppAudiosConst: { [key: number]: string } = {
  1: `${AppStoragePathsConst.audiosPath}/${AppStoragePathsConst.maherAlMueaqly}`,
  2: `${AppStoragePathsConst.audiosPath}/${AppStoragePathsConst.khaledAlabi}`,
  3: `${AppStoragePathsConst.audiosPath}/${AppStoragePathsConst.abdulRahmanAlSudais}`,
  4: `${AppStoragePathsConst.audiosPath}/${AppStoragePathsConst.abuBakrAlShatri}`,
}



export const AppImagesRecitersConst: { [key: number]: string } = {
  1: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.maherAlMueaqlyImages}`,
  2: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.khaledAlabiImages}`,
  3: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.abdulRahmanAlSudaisImages}`,
  4: `${AppStoragePathsConst.imagesPath}/${AppStoragePathsConst.abuBakrAlShatriImages}`,
}

