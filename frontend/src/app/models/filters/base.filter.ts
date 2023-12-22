export interface BaseFilter {
  page?: number;
  limit?: number;

  params?: { [key: string]: any }[];
}