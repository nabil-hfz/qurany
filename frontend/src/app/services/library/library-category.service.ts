import { Injectable } from '@angular/core';
import { LibraryModel } from '../../models/library.model';
import { DataService } from '../data-service';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { BaseFilter } from '../../models/filters/base.filter';
import { Observable } from 'rxjs';
import { LibraryLanguageModel } from '../../models/library-language.model';
import { LibraryCategoryModel } from '../../models/library-category.model';

@Injectable({
  providedIn: 'root'
})
export class LibraryCategoryService extends DataService<LibraryCategoryModel> {


  constructor(httpClient: HttpClient) {
    const url = `${environment.apiUrl}/library/category`;

    super(url, httpClient);
  }

  getCategories(filter?: BaseFilter): Observable<LibraryCategoryModel[]> {
    let params = this.getAllFields(filter);

    return this.getAll(params);
  }

}
