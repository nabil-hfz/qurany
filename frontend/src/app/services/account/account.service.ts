import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DataService } from '../data-service';
import { environment } from '../../../environments/environment';
import { AppBaseModel } from '../../models/base.model';
import { LoginResponseModel } from '../../models/user.model';
import { map } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AccountService extends DataService<any> {

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
    console.log(`login Email: ${email}, Password: ${password}`);
    try {
      const result = this.create({ "email": email, "password": password }, 'login');
      console.log(result);
    } catch (error: any) {
      console.error('error is ', error);

    }
    // .pipe((response) => {
    //   console.log('response ', response);
    //   return response;
    // });
  }
}
