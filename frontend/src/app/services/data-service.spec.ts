import { HttpClient, HttpErrorResponse, HttpParams } from '@angular/common/http';
import { of, throwError } from 'rxjs';
import { DataService } from './data-service';
import { AppNotFoundError } from '../../../common/not-found-error';
import { PortfolioEntryModel } from '../../../models/portfolio-entry.model';

describe('DataService', () => {
  let service: DataService<any>;
  let httpClientSpy: jasmine.SpyObj<HttpClient>;

  beforeEach(() => {
    httpClientSpy = jasmine.createSpyObj('HttpClient', ['get', 'post', 'put', 'delete']);
    service = new DataService<any>('test-url', httpClientSpy);
  });

  it('should retrieve all items', (done: DoneFn) => {
    const data = new PortfolioEntryModel(
      "6571df849351c94ff4d89b86",
      "Test 9",
      "Description adsjflkasjdflkaj slkfjsalkdfj lkasj flkasjdf lkadsjlkf jsalkdf jlksdajflksadjf kdsajlk jsalk jflksajflks ajlkj flksadj lfksjalkf jlksajdfkasjdfkhjeqw iohtrqiwueh vncxam bnvkhegfjq hwwoiq fjwoieqjf  ",
      "http://localhost:8080",
      "http://localhost:8080/uploads/image-1701961604905.png",
      true,
      new Date(),
    );

    const expectedData = [data];
    httpClientSpy.get.and.returnValue(of(expectedData));

    service.getAll(new HttpParams()).subscribe(data => {
      expect(data).toEqual(expectedData);
      done();
    });
  });

  it('should retrieve an item by ID', (done: DoneFn) => {
    const mockItem = { id: 1, name: 'Test Item' };
    httpClientSpy.get.and.returnValue(of(mockItem));

    service.getById('1').subscribe(data => {
      expect(data).toEqual(mockItem);
      done();
    });
  });

  it('should create a new item', (done: DoneFn) => {
    const newItem = { name: 'New Item' };
    httpClientSpy.post.and.returnValue(of(newItem));

    service.create(newItem).subscribe(data => {
      expect(data).toEqual(newItem);
      done();
    });
  });

  it('should update an existing item', (done: DoneFn) => {
    const updatedItem = { id: 1, name: 'Updated Item' };
    httpClientSpy.put.and.returnValue(of(updatedItem));

    service.update(updatedItem, '1').subscribe(data => {
      expect(data).toEqual(updatedItem);
      done();
    });
  });

  it('should delete an item', (done: DoneFn) => {
    httpClientSpy.delete.and.returnValue(of(null));

    service.delete('1').subscribe(response => {
      expect(response).toBeNull();
      done();
    });
  });

  it('should handle 404 error', (done: DoneFn) => {
    const errorResponse = new HttpErrorResponse({ status: 404, statusText: 'Not Found' });

    httpClientSpy.get.and.returnValue(throwError(() => errorResponse));

    service.getById('1').subscribe({
      next: () => fail('expected an error'),
      error: (error) => {
        expect(error).toBeInstanceOf(AppNotFoundError);
        done();
      }
    });
  });

});
