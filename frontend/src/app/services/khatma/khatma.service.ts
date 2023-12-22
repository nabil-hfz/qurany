import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { DataService } from '../data-service';
import { environment } from '../../../environments/environment';
import { KhatmaModel } from '../../models/khatma.model';
import { BaseFilter } from '../../models/filters/base.filter';

@Injectable({
  providedIn: 'root'
})
export class KhatmaService extends DataService<KhatmaModel> {

  constructor(httpClient: HttpClient) {
    const url = `${environment.apiUrl}/khatma`;
    super(url, httpClient);
  }

  getKhatmat(filter?: BaseFilter) {
    let params = this.getAllFields(filter)
    return this.getAll(params);
  }

  getKhatma(khatmaId: number) {
    return this.getById(khatmaId);
   
  }
}
