import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { DataService } from '../data-service';
import { RecitationModel } from '../../models/recitation.model';
import { BaseFilter } from '../../models/filters/base.filter';

@Injectable({
  providedIn: 'root'
})
export class RecitationsService extends DataService<RecitationModel>{
  constructor(httpClient: HttpClient) {
    const url = `${environment.apiUrl}/recitation`;
    super(url, httpClient);
  }

  getRecitations(filter?: BaseFilter) {
    let params = this.getAllFields(filter)
    return this.getAll(params);
  }

  getRecitation(id: number) {
    return this.getById(id);

  }
}
