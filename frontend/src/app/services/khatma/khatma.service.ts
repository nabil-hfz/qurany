import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { DataService } from '../data-service';
import { environment } from '../../environments/environment';
import { KhatmaModel } from '../../models/khatma.model';
import { BaseFilter } from '../../models/filters/base.filter';

@Injectable({
  providedIn: 'root'
})
export class KhatmaService extends DataService<KhatmaModel> {

  constructor(httpClient: HttpClient) {
    let url = `${environment.apiUrl}/khatma`;
    super(url, httpClient);
  }

  getKhatmat(filter: BaseFilter) {
    const params = new HttpParams();
    params.append('page', filter?.page ?? 0);
    params.append('limit', filter?.limit ?? 20);
    return this.getAll(params);
  }

}
