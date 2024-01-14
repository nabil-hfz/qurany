import { DataService } from './data-service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { of, throwError } from 'rxjs';
import { AppNotFoundError } from '../common/not-found-error';
import { AppBadInputError } from '../common/bad-input';

describe('DataService', () => {
  let service: DataService<any>;
  let httpClientSpy: jasmine.SpyObj<HttpClient>;

  beforeEach(() => {
    httpClientSpy = jasmine.createSpyObj('HttpClient', ['get', 'post', 'put', 'delete']);
    service = new DataService<any>('some-url', httpClientSpy);
  });

  describe('getAll', () => {
    it('should return expected data (HttpClient called once)', () => {
      const expectedData = [{ id: 1, name: 'A' }, { id: 2, name: 'B' }];

      httpClientSpy.get.and.returnValue(of(expectedData));

      service.getAll().subscribe({
        next: data => expect(data).withContext('expected data').toEqual(expectedData),
        error: fail,
      });

      expect(httpClientSpy.get.calls.count()).toBe(1, 'one call');
    });

    it('should return an error when the server returns a 404', () => {
      const errorResponse = new HttpErrorResponse({
        error: 'test 404 error',
        status: 404, statusText: 'Not Found'
      });

      httpClientSpy.get.and.returnValue(throwError(() => errorResponse));

      service.getAll().subscribe({
        next: (data) => fail('expected an error, not data'),
        error: (error) => expect(error).toBeInstanceOf(AppNotFoundError),
      });
    });
  });

  describe('getById', () => {
    it('should return expected item (HttpClient called once)', () => {
      const expectedItem = { id: 1, name: 'A' };

      httpClientSpy.get.and.returnValue(of(expectedItem));


      service.getById(1).subscribe({
        next: data => expect(data).withContext('expected data').toEqual(expectedItem),
        error: fail,
      });

      expect(httpClientSpy.get.calls.count()).withContext('one call').toBe(1);
    });

    it('should return an error when the server returns a 404 for getById', () => {
      const errorResponse = new HttpErrorResponse({
        error: 'test 404 error',
        status: 404, statusText: 'Not Found'
      });

      httpClientSpy.get.and.returnValue(throwError(() => errorResponse));

      service.getById(999).subscribe({
        error: (error) => expect(error).toBeInstanceOf(AppNotFoundError),
        next: (data) => fail('expected an error, not data'),
      });
    });

  });


  describe('create', () => {
    it('should send POST request to create a new item', () => {
      const newItem = { name: 'New Item' };
      const responseItem = { id: 1, ...newItem };

      httpClientSpy.post.and.returnValue(of(responseItem));

      service.create(newItem).subscribe({
        next: data => expect(data).withContext('expected response').toEqual(responseItem),
        error: fail,
      });

      expect(httpClientSpy.post.calls.count()).withContext('one call').toBe(1);
      expect(httpClientSpy.post.calls.mostRecent().args[0]).toBe('some-url');
      expect(httpClientSpy.post.calls.mostRecent().args[1]).toEqual(newItem);
    });

    it('should handle server errors for create method', () => {
      const newItem = { name: 'New Item' };
      const errorResponse = new HttpErrorResponse({
        error: 'test 400 error',
        status: 400, statusText: 'Bad Request'
      });

      httpClientSpy.post.and.returnValue(throwError(() => errorResponse));

      service.create(newItem).subscribe({
        next: () => fail('expected an error, not data'),
        error: (error) => expect(error).toBeInstanceOf(AppBadInputError),
      });
    });

  });

  describe('update', () => {
    it('should send PUT request to update an item', () => {
      const updateItem = { id: 1, name: 'Updated Item' };

      httpClientSpy.put.and.returnValue(of(updateItem));

      service.update(updateItem, updateItem.id).subscribe({
        next: data => expect(data).withContext('expected response').toEqual(updateItem),
        error: fail,
      });

      expect(httpClientSpy.put.calls.count()).withContext('one call').toBe(1);
      expect(httpClientSpy.put.calls.mostRecent().args[0]).toBe(`some-url/${updateItem.id}`);
      expect(httpClientSpy.put.calls.mostRecent().args[1]).toEqual(updateItem);
    });

    it('should handle server errors for update method', () => {
      const updateItem = { id: 1, name: 'Updated Item' };
      const errorResponse = new HttpErrorResponse({
        error: 'test 400 error',
        status: 400, statusText: 'Bad Request'
      });

      httpClientSpy.put.and.returnValue(throwError(() => errorResponse));

      service.update(updateItem, updateItem.id).subscribe({
        next: () => fail('expected an error, not data'),
        error: (error) => expect(error).toBeInstanceOf(AppBadInputError),
      });
    });
  });

});

// ng test --include=src/app/services/data-service.spec.ts
