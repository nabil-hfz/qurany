import { UserEntity } from './../../../../../backend/src/db/entities/user.entity';
import { Injectable } from '@angular/core';
import { DataService } from '../data-service';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AccountService extends DataService<UserEntity> {

  /**
   * Constructs an instance of the AccountService.
   * @param httpClient - The HttpClient service for making HTTP requests.
   */
  constructor(httpClient: HttpClient) {
    // Define the URL for the Account service API endpoint.
    const url = `${environment.apiUrl}/account`;

    // Call the constructor of the parent DataService class with the API URL and HttpClient.
    super(url, httpClient);
  }

  login(email: string, password: string) {
    return this.create({ email, password }, 'login');
  }
}
