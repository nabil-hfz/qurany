import { LocalizedModel } from './localized.model';
import { ReciterModel } from './reciter.model';
import { AppBaseModel } from './base.model';

/**
 * Enumeration of Recitation Types.
 */
export enum RecitationTypes {
  Hafs = 1,
  Shoaba = 2,
}

/**
 * List of available Recitation Types.
 */
export const RecitationTypesList = [
  RecitationTypes.Hafs,
  RecitationTypes.Shoaba,
];

/**
 * Represents a Recitation Model.
 */
export class RecitationModel extends AppBaseModel {

  /**
   * The title of the recitation.
   */
  public title!: LocalizedModel;

  /**
   * The image associated with the recitation.
   */
  public image?: string;

  /**
   * The audio URL of the recitation.
   */
  public audio?: string;

  /**
   * The reciter of the recitation.
   */
  public reciter!: ReciterModel;

  /**
   * The type of recitation (e.g., Hafs or Shoaba).
   */
  public recitationType!: RecitationTypes;

  /**
   * The ID of the associated Khatma.
   */
  public khatmaId!: number;

  /**
   * The sequence number of the recitation.
   */
  public sequence?: number;

  /**
   * The total number of downloads for the recitation.
   */
  public totalDownloads: number = 0;

  /**
   * The total number of plays for the recitation.
   */
  public totalPlays: number = 0;

  /**
   * The duration of the recitation in seconds.
   */
  public duration: number = 0;
}
