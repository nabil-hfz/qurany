/**
 * Abstract base class for application models.
 */
export abstract class AppBaseModel {

  /**
   * The unique identifier of the model.
   */
  public id!: number;

  /**
   * The date when the model was created.
   */
  public createdAt!: Date;

  /**
   * The date when the model was last updated, if available.
   */
  public updatedAt?: Date;
}
