import { LocalizedModel } from './localized.model';
import { RecitationTypes } from './recitation.model';
import { AppBaseModel } from './base.model';

/**
 * Represents a reciter of Quranic recitations.
 */
export class ReciterModel extends AppBaseModel {

  /**
   * The name of the reciter.
   */
  name!: LocalizedModel;

  /**
   * The biography of the reciter.
   */
  bio!: LocalizedModel;

  /**
   * The image URL of the reciter.
   */
  image?: string;

  /**
   * An array of recitation types associated with the reciter.
   */
  recitationTypes?: RecitationTypes[];

  /**
   * The total number of plays for the reciter's recitations.
   */
  totalPlays: number = 0;

  /**
   * The total number of downloads for the reciter's recitations.
   */
  totalDownloads: number = 0;

  /**
   * The number of completed Quranic readings (Khatmat) by the reciter.
   */
  numberOfKhatmat: number = 0;
}
