/**
 * Interface for a base filter used for querying data.
 */
export interface BaseFilter {
  /**
   * The page number for paginating results.
   */
  page?: number;

  /**
   * The maximum number of items to retrieve per page.
   */
  limit?: number;

  /**
   * Additional parameters for filtering data.
   * These parameters are represented as key-value pairs.
   */
  params?: { [key: string]: any }[];
}
