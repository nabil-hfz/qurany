import { AppBaseModel } from "./base.model";
import { LibraryCategoryModel } from "./library-category.model";
import { LibraryLanguageModel } from "./library-language.model";

/**
 * Represents a library resource model with associated data.
 */
export class LibraryModel extends AppBaseModel {

  /**
   * The name of the library resource.
   */
  public name!: string;

  /**
   * The language of the library resource.
   */
  public language!: LibraryLanguageModel;

  /**
   * The categories associated with the library resource.
   */
  public categories!: LibraryCategoryModel[];

  /**
   * The file path or URL of the library resource.
   */
  public file!: string;

  /**
   * The thumbnail image path or URL of the library resource.
   */
  public thumbnail?: string;

  /**
   * The total number of views for the library resource.
   */
  public totalViews?: number;

  /**
   * The total number of downloads for the library resource.
   */
  public totalDownloads?: number;

  /**
   * A description of the library resource.
   */
  public description?: string;
}
