import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { RecitersService } from './reciters.service';
import {  HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { ReciterModel } from '../../models/reciter.model';
import { ReciterFilter } from '../../models/filters/reciter.filter';
import { RecitationTypes } from '../../models/recitation.model';
import { LocalizedModel } from '../../models/localized.model';

describe('RecitersService', () => {
  let service: RecitersService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [RecitersService]
    });

    service = TestBed.inject(RecitersService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  describe('getRecitersList', () => {
    it('should return expected list of reciters (GET request)', () => {
      const mockReciters: ReciterModel[] = [
        {
          id: 1,
          name: { ar: 'القارئ 1', en: 'Reciter 1', } as LocalizedModel,
          bio: { ar: 'سيرة ذاتية 1', en: 'Biography 1' } as LocalizedModel,
          image: 'path/to/image1.jpg',
          recitationTypes: [RecitationTypes.Hafs, RecitationTypes.Shoaba],
          totalPlays: 100,
          totalDownloads: 50,
          numberOfKhatmat: 3,
          createdAt: new Date(),
        },
      ];
      const filter: ReciterFilter = { page: 1, limit: 10 };  

      service.getRecitersList(filter).subscribe(reciters => {
        expect(reciters.length).toBeGreaterThan(0);
        expect(reciters).toEqual(mockReciters);
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/reciter?page=1&limit=10`);
      expect(req.request.method).toBe('GET');
      req.flush(mockReciters);
    });


  });


  describe('getRecitersList Error Handling', () => {
    it('should handle error when server returns an error for getRecitersList', () => {
      const filter: ReciterFilter = { page: 1, limit: 10 };
      const errorResponse = new HttpErrorResponse({
        error: 'test error',
        status: 500, statusText: 'Internal Server Error'
      });

      service.getRecitersList(filter).subscribe({
        next: () => fail('expected an error, not a list of reciters'),
        error: error => expect(error.message).toContain('500 Internal Server Error')
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/reciter?page=1&limit=10`);
      expect(req.request.method).toBe('GET');
      req.flush('Error loading reciters', errorResponse);
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});

