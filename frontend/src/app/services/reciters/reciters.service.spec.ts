import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { RecitersService } from './reciters.service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { ReciterModel } from '../../models/reciter.model';
import { ReciterFilter } from '../../models/filters/reciter.filter';
import { RecitationTypes } from '../../models/recitation.model';
import { LocalizedModel } from '../../models/localized.model';

import { AppNotFoundError } from '../../common/not-found-error';

describe('RecitersService', () => {
  let service: RecitersService;
  let httpTestingController: HttpTestingController;
  const apiUrl = `${environment.apiUrl}/reciter?page=1&limit=10`;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [RecitersService]
    });
    service = TestBed.inject(RecitersService);
    httpTestingController = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpTestingController.verify();
  });

  describe('getRecitersList', () => {
    it('should call getAll with the correct URL and parameters', () => {
      const filter = { page: 1, limit: 10 };
      service.getRecitersList(filter).subscribe();

      const req = httpTestingController.expectOne(`${apiUrl}`);
      expect(req.request.method).toEqual('GET');
    });

    it('should correctly process a valid response', () => {

      const mockResponse = {
        items: [
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
        ]
      };
      const filter = { page: 1, limit: 10 };
      service.getRecitersList(filter).subscribe(reciters => {
        expect(reciters).toEqual(mockResponse.items);
      });

      const req = httpTestingController.expectOne(`${apiUrl}`);
      req.flush(mockResponse);
    });

    it('should handle errors', () => {
      const filter = { page: 1, limit: 10 };
      const status = 404;
      const statusText = 'Not Found';

      service.getRecitersList(filter).subscribe({
        next: () => fail('should have failed with 404 error'),
        error: (error) => {
          console.log(error);
          expect(error).toBeInstanceOf(AppNotFoundError);
        }
      }
      );

      const req = httpTestingController.expectOne(`${apiUrl}`);
      req.flush('Error', { status: status, statusText: statusText });
    });
  });
});

// ng test --include=src/app/services/reciters/reciters.service.spec.ts
