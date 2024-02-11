import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DataService } from '../data-service';
import { environment } from '../../../environments/environment';
import { KhatmaModel } from '../../models/khatma.model';
import { BaseFilter } from '../../models/filters/base.filter';

@Injectable({
  providedIn: 'root'
})
export class KhatmaService extends DataService<KhatmaModel> {

  /**
   * Constructs an instance of the KhatmaService.
   * @param httpClient - The HttpClient service for making HTTP requests.
   */
  constructor(httpClient: HttpClient) {
    // Define the URL for the Khatma service API endpoint.
    const url = `${environment.apiUrl}/khatma`;

    // Call the constructor of the parent DataService class with the API URL and HttpClient.
    super(url, httpClient);
  }

  /**
   * Retrieves a list of Khatmat based on the provided filter parameters.
   * @param filter - An optional filter object to apply filter criteria.
   * @returns An Observable that emits the list of Khatmat.
   */
  getKhatmat(filter?: BaseFilter) {
    // Generate query parameters from the provided filter object.
    let params = this.getAllFields(filter);

    // Call the getAll method of the parent DataService class to fetch Khatmat.
    return this.getAll(params);
  }

  /**
   * Retrieves a single Khatma by its ID.
   * @param khatmaId - The ID of the Khatma to retrieve.
   * @returns An Observable that emits the Khatma with the specified ID.
   */
  getKhatma(khatmaId: number) {
    // Call the getById method of the parent DataService class to fetch a specific Khatma.
    return this.getById(khatmaId);
  }
}
