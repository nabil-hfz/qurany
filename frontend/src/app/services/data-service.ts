import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { Observable, catchError, throwError, map } from 'rxjs';
import { AppBadInputError } from '../common/bad-input';
import { AppNotFoundError } from '../common/not-found-error';
import { AppError } from '../common/app-error';
import { BaseFilter } from '../models/filters/base.filter';


export class DataService<T extends any> {
    get url() { return URL };

    
    constructor(protected URL: string, protected http: HttpClient) { }

    getAll(params?: HttpParams): Observable<any> {
        return this.http
            .get<T[]>(this.URL, { params: params })
            .pipe(
                map((response: any) => {
                    if (response.items)
                        return response.items;
                    return response;
                }),
                catchError(this.handleError)
            );
    }

    getById(id: number): Observable<T> {
        const url = this.URL + '/' + id;
        console.log(url);
        const result = this.http
            .get<T>(url)
            .pipe(catchError(this.handleError));
        return result;
    }

    create(resource: any): Observable<T> {
        return this.http
            .post<T>(this.URL, resource)
            .pipe(catchError(this.handleError));
    }

    update(resource: any, id: number): Observable<T> {
        return this.http
            .put<T>(this.URL + '/' + id, resource)
            .pipe(catchError(this.handleError));


    }

    delete(id: number): Observable<T> {
        // return throwError(() => { return new AppError() });
        return this.http.delete<T>(this.URL + '/' + id)
            .pipe(catchError(this.handleError));

    }

    private handleError(error: HttpErrorResponse) {
        console.error('error.error is ', error.message);

        return throwError(() => {
            if (error.status == 400) {
                return new AppBadInputError();
            }
            if (error.status == 404) {
                return new AppNotFoundError();
            }
            else {
                return new AppError(error);
            }
        });
    }

    getAllFields(filter?: BaseFilter) {
        let params = new HttpParams();
        params = params.append('page', filter?.page ?? 0);
        params = params.append('limit', filter?.limit ?? 20);

        filter?.params?.forEach(obj => {
            Object.keys(obj).forEach(key => {
                params = params.append(key, obj[key]);
            });
        });

        return params;
    }

}
