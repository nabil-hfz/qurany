import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { DataService } from '../data-service';
import { ReciterModel } from '../../models/reciter.model';
import { KhatmaFilter } from '../../models/filters/khatma.filter';
import { ReciterFilter } from '../../models/filters/reciter.filter';

@Injectable({
  providedIn: 'root'
})
export class RecitersService extends DataService<ReciterModel> {

  constructor(httpClient: HttpClient) {
    // Define the API URL for reciters.
    const url = `${environment.apiUrl}/reciter`;
    
    // Call the constructor of the parent class (DataService) with the API URL and HttpClient.
    super(url, httpClient);
  }

  /**
   * Retrieves a list of reciters based on the provided filter.
   * @param filter - Filter criteria for querying reciters (e.g., page and limit).
   * @returns An observable of the list of reciters.
   */
  getRecitersList(filter: ReciterFilter) {
    // Create HTTP query parameters based on the provided filter.
    let params = new HttpParams();
    params = params.set('page', filter?.page?.toString() ?? '0');
    params = params.set('limit', filter?.limit?.toString() ?? '20');
    
    // Make an HTTP GET request to retrieve the list of reciters using the parent class's getAll method.
    return this.getAll(params);
  }
}
