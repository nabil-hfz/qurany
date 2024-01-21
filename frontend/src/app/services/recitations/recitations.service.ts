import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { DataService } from '../data-service';
import { RecitationModel } from '../../models/recitation.model';
import { BaseFilter } from '../../models/filters/base.filter';

@Injectable({
  providedIn: 'root'
})
export class RecitationsService extends DataService<RecitationModel> {
  constructor(httpClient: HttpClient) {
    // Define the API URL for recitations.
    const url = `${environment.apiUrl}/recitation`;
    
    // Call the constructor of the parent class (DataService) with the API URL and HttpClient.
    super(url, httpClient);
  }

  /**
   * Retrieves a list of recitations based on the provided filter.
   * @param filter - Optional filter criteria for querying recitations.
   * @returns An observable of the list of recitations.
   */
  getRecitations(filter?: BaseFilter) {
    // Generate HTTP query parameters based on the filter.
    const params = this.getAllFields(filter);
    
    // Make an HTTP GET request to retrieve the list of recitations using the parent class's getAll method.
    return this.getAll(params);
  }

  /**
   * Retrieves a specific recitation by its ID.
   * @param id - The ID of the recitation to retrieve.
   * @returns An observable of the recitation with the specified ID.
   */
  getRecitation(id: number) {
    // Make an HTTP GET request to retrieve the recitation by ID using the parent class's getById method.
    return this.getById(id);
  }
}
