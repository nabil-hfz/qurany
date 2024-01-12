import { AppBaseModel } from "./base.model";
import { LibraryCategoryModel } from "./library-category.model";
import { LibraryLanguageModel } from "./library-language.model";


export class LibraryModel extends AppBaseModel {

  public name!: string;
  public language!: LibraryLanguageModel;
  public categories!: LibraryCategoryModel[];
  public file!: string;
  public thumbnail?: string;
  public totalViews?: number;
  public totalDownloads?: number;
  public description?: string;

}