import { AppBaseModel } from './base.model';

/**
 * Represents a file with associated metadata.
 */
export class FileModel extends AppBaseModel {

  /**
   * The URL of the file.
   */
  public url!: string;

  /**
   * The size of the file in bytes, if available.
   */
  public size?: number;

  /**
   * The MIME type of the file, if available.
   */
  public mimetype?: string;

  /**
   * The name of the file, if available.
   */
  public name?: string;
}
