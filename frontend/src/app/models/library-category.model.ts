import { AppBaseModel } from "./base.model";
import { LocalizedModel } from "./localized.model";

/**
 * Represents a library category model with associated data.
 */
export class LibraryCategoryModel extends AppBaseModel {

  /**
   * The name of the library category, possibly in multiple languages.
   */
  public name!: LocalizedModel;
}
