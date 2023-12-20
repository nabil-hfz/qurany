import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { DataService } from '../data-service';
import { ReciterModel } from '../../models/reciter.model';
import { KhatmaFilter } from '../../models/filters/khatma.filter';
import { ReciterFilter } from '../../models/filters/reciter.filter';

@Injectable({
  providedIn: 'root'
})
export class RecitersService extends DataService<ReciterModel>{

  constructor(httpClient: HttpClient) {
    let url = `${environment.apiUrl}/reciter`;
    super(url, httpClient);
  }

  getRecitersList(filter: ReciterFilter) {
    const params = new HttpParams();
    params.append('page', filter?.page ?? 0);
    params.append('limit', filter?.limit ?? 20);
    return this.getAll(params);
  }
}
