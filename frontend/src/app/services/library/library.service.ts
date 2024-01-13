import { Injectable } from '@angular/core';
import { LibraryModel } from '../../models/library.model';
import { DataService } from '../data-service';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { BaseFilter } from '../../models/filters/base.filter';

@Injectable({
  providedIn: 'root'
})
export class LibraryService extends DataService<LibraryModel> {

  constructor(httpClient: HttpClient) {
    const url = `${environment.apiUrl}/library`;
    super(url, httpClient);
  }

  getLibraryFiles(filter?: BaseFilter) {
    let params = this.getAllFields(filter)
    return this.getAll(params);
  }

  getFileDetails(id: number) {
    return this.getById(id);
   
  }
}
