import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { Observable, catchError, throwError, map } from 'rxjs';
import { AppBadInputError } from '../common/bad-input';
import { AppNotFoundError } from '../common/not-found-error';
import { AppError } from '../common/app-error';
import { BaseFilter } from '../models/filters/base.filter';

/**
 * A generic data service for handling CRUD operations with a RESTful API.
 * @typeparam T - The type of data the service handles.
 */
export class DataService<T extends any> {
  /**
   * The base URL of the API.
   */
  get url() { return this.URL };

  /**
   * Creates an instance of the DataService.
   * @param URL - The base URL of the API.
   * @param http - The HttpClient for making HTTP requests.
   */
  constructor(protected URL: string, protected http: HttpClient) { }

  /**
   * Retrieves a list of resources based on optional query parameters.
   * @param params - Optional query parameters.
   * @returns An observable of the list of resources.
   */
  getAll(params?: HttpParams, path?: string): Observable<any> {
    let url = this.URL;
    if (path)
      url = `${this.URL}/${path}`;
    return this.http
      .get<T[]>(url, { params: params })
      .pipe(
        map((response: any) => {
          if (response.items)
            return response.items;
          return response;
        }),
        catchError(this.handleError)
      );
  }

  /**
   * Retrieves a single resource by its ID.
   * @param id - The ID of the resource to retrieve.
   * @returns An observable of the resource.
   */
  getById(id: number): Observable<T> {
    const url = `${this.URL}/${id}`;
    return this.http
      .get<T>(url)
      .pipe(catchError(this.handleError));
  }

  /**
   * Creates a new resource.
   * @param resource - The resource data to create.
   * @returns An observable of the created resource.
   */
  create(resource: any, path?: string): Observable<T> {
    let url = this.URL;
    if (path)
      url = `${this.URL}/${path}`;
      console.log(`create url: ${url}`);
      return this.http
      .post<T>(url, resource)
      .pipe(catchError(this.handleError));
  }

  /**
   * Updates an existing resource by its ID.
   * @param resource - The updated resource data.
   * @param id - The ID of the resource to update.
   * @returns An observable of the updated resource.
   */
  update(resource: any, id: number): Observable<T> {
    const url = `${this.URL}/${id}`;
    return this.http
      .put<T>(url, resource)
      .pipe(catchError(this.handleError));
  }

  /**
   * Deletes a resource by its ID.
   * @param id - The ID of the resource to delete.
   * @returns An observable of the deleted resource.
   */
  delete(id: number): Observable<T> {
    const url = `${this.URL}/${id}`;
    return this.http
      .delete<T>(url)
      .pipe(catchError(this.handleError));
  }

  /**
   * Handles HTTP errors and maps them to custom error types.
   * @param error - The HTTP error response.
   * @returns An observable of a custom error type.
   */
  private handleError(error: HttpErrorResponse) {
    console.error('error.error is ', error.message);

    return throwError(() => {
      if (error.status == 400) {
        return new AppBadInputError();
      }
      if (error.status == 404) {
        return new AppNotFoundError();
      } else {
        return new AppError(error);
      }
    });
  }

  /**
   * Creates HTTP query parameters based on the provided filter.
   * @param filter - Filter criteria for querying resources (e.g., page and limit).
   * @returns HTTP query parameters.
   */
  getAllFields(filter?: BaseFilter) {
    let params = new HttpParams();
    params = params.append('page', filter?.page?.toString() ?? '1');
    params = params.append('limit', filter?.limit?.toString() ?? '30');

    filter?.params?.forEach(obj => {
      Object.keys(obj).forEach(key => {
        params = params.append(key, obj[key]);
      });
    });

    return params;
  }
}
