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
export class LibraryService extends DataService<LibraryModel> {

  /**
   * Constructs an instance of the LibraryService.
   * @param httpClient - The HttpClient service for making HTTP requests.
   */
  constructor(httpClient: HttpClient) {
    // Define the URL for the Library service API endpoint.
    const url = `${environment.apiUrl}/library`;

    // Call the constructor of the parent DataService class with the API URL and HttpClient.
    super(url, httpClient);
  }

  /**
   * Retrieves a list of library files based on the provided filter parameters.
   * @param filter - An optional filter object to apply filter criteria.
   * @returns An Observable that emits the list of library files.
   */
  getLibraryFiles(filter?: BaseFilter) {
    // Generate query parameters from the provided filter object.
    let params = this.getAllFields(filter);

    // Call the getAll method of the parent DataService class to fetch library files.
    return this.getAll(params);
  }

  /**
   * Retrieves details of a specific library file by its ID.
   * @param id - The ID of the library file to retrieve details for.
   * @returns An Observable that emits the details of the library file with the specified ID.
   */
  getFileDetails(id: number) {
    // Call the getById method of the parent DataService class to fetch details of a specific library file.
    return this.getById(id);
  }

  getLanguages(filter?: BaseFilter): Observable<LibraryLanguageModel[]> {
    let params = this.getAllFields(filter);


    return this.getAll(params, 'language');
  }

  getCategories(filter?: BaseFilter): Observable<LibraryCategoryModel[]> {
    let params = this.getAllFields(filter);
    
    return this.getAll(params, 'category');
  }

  createFileEntry(fileEntryData: FormData): Observable<any> {
    return this.create(fileEntryData)
  }
}
