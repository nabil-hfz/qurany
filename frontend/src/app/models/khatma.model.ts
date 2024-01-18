import { AppBaseModel } from './base.model';
import { LocalizedModel } from './localized.model';
import { ReciterModel } from './reciter.model';

/**
 * Represents a Khatma model with associated data.
 */
export class KhatmaModel extends AppBaseModel {

  /**
   * The name of the Khatma, possibly in multiple languages.
   */
  public name!: LocalizedModel;

  /**
   * The type of recitation for the Khatma, if available.
   */
  public recitationType?: number;

  /**
   * The total number of downloads for the Khatma.
   */
  public totalDownloads: number = 0;

  /**
   * The total number of plays for the Khatma.
   */
  public totalPlays: number = 0;

  /**
   * The associated reciter for the Khatma, if available.
   */
  public reciter?: ReciterModel;
}
