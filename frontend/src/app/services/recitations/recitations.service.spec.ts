import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { RecitationsService } from './recitations.service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { RecitationModel, RecitationTypes } from '../../models/recitation.model';
import { throwError, of } from 'rxjs';
import { BaseFilter } from '../../models/filters/base.filter';
describe('RecitationsService', () => {
  let service: RecitationsService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [RecitationsService]
    });

    service = TestBed.inject(RecitationsService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  describe('getRecitations', () => {
    it('should return expected recitations (GET request)', () => {
      const mockRecitations: RecitationModel[] = [
        // ... populate with mock data ...
      ];

      service.getRecitations().subscribe(recitations => {
        expect(recitations.length).toBeGreaterThan(0);
        expect(recitations).toEqual(mockRecitations);
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/recitation`);
      expect(req.request.method).toBe('GET');
      req.flush(mockRecitations);
    });

    // Add error handling test here
  });

  describe('getRecitation', () => {
    it('should return recitation details for a given ID (GET request)', () => {
      const mockRecitationDetails: RecitationModel = { /* ... populate with mock data ... */ };
      const recitationId = 1;

      service.getRecitation(recitationId).subscribe(detail => {
        expect(detail).toEqual(mockRecitationDetails);
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/recitation/${recitationId}`);
      expect(req.request.method).toBe('GET');
      req.flush(mockRecitationDetails);
    });

    // Add error handling test here
  });

  // Error Handling Tests for getRecitations
  describe('getRecitations Error Handling', () => {
    it('should handle error when server returns an error for getRecitations', () => {
      const errorResponse = new HttpErrorResponse({
        error: 'test error',
        status: 500, statusText
          : 'Internal Server Error'
      });
      service.getRecitations().subscribe({
        next: () => fail('expected an error, not recitations'),
        error: error => expect(error.message).toContain('500 Internal Server Error')
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/recitation`);
      expect(req.request.method).toBe('GET');
      req.flush('Error loading recitations', errorResponse);
    });

  });
  // Error Handling Tests for getRecitation
  describe('getRecitation Error Handling', () => {
    it('should handle error when server returns an error for getRecitation', () => {
      const recitationId = 1;
      const errorResponse = new HttpErrorResponse({
        error: 'test error',
        status: 500, statusText: 'Internal Server Error'
      });
      service.getRecitation(recitationId).subscribe({
        next: () => fail('expected an error, not recitation details'),
        error: error => expect(error.message).toContain('500 Internal Server Error')
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/recitation/${recitationId}`);
      expect(req.request.method).toBe('GET');
      req.flush('Error loading recitation details', errorResponse);
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});