import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { RecitersService } from './reciters.service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { ReciterModel } from '../../models/reciter.model';
import { ReciterFilter } from '../../models/filters/reciter.filter';
import { RecitationTypes } from '../../models/recitation.model';
import { LocalizedModel } from '../../models/localized.model';

import { HttpParams } from '@angular/common/http';
import { AppNotFoundError } from '../../common/not-found-error';
// describe('RecitersService', () => {
//   let service: RecitersService;
//   let httpMock: HttpTestingController;

//   beforeEach(() => {
//     TestBed.configureTestingModule({
//       imports: [HttpClientTestingModule],
//       providers: [RecitersService]
//     });

//     httpMock = TestBed.inject(HttpTestingController);
//     service = TestBed.inject(RecitersService);
//   });

//   afterEach(() => {
//     httpMock.verify();
//   });

//   describe('getRecitersList', () => {
//     it('should return expected list of reciters (GET request)', () => {
//       const mockReciters: ReciterModel[] = [
//         {
//           id: 1,
//           name: { ar: 'القارئ 1', en: 'Reciter 1', } as LocalizedModel,
//           bio: { ar: 'سيرة ذاتية 1', en: 'Biography 1' } as LocalizedModel,
//           image: 'path/to/image1.jpg',
//           recitationTypes: [RecitationTypes.Hafs, RecitationTypes.Shoaba],
//           totalPlays: 100,
//           totalDownloads: 50,
//           numberOfKhatmat: 3,
//           createdAt: new Date(),
//         },
//       ];
//       const filter: ReciterFilter = { page: 1, limit: 10 };

//       service.getRecitersList(filter).subscribe(reciters => {
//         console.log(reciters);
//         expect(reciters.length).toBeGreaterThan(0);
//         expect(reciters).toEqual(mockReciters);
//       });

//       const req = httpMock.expectOne(`${environment.apiUrl}/reciter`);
//       expect(req.request.method).toBe('GET');
//       req.flush(mockReciters);
//     });


//   });


//   describe('getRecitersList Error Handling', () => {
//     it('should handle error when server returns an error for getRecitersList', () => {
//       const filter: ReciterFilter = { page: 1, limit: 10 };
//       const errorResponse = new HttpErrorResponse({
//         error: 'test error',
//         status: 500,
//         statusText: 'Internal Server Error'
//       });

//       service.getRecitersList(filter).subscribe({
//         next: () => fail('expected an error, not a list of reciters'),
//         error: error => expect(error.message).toContain('Internal Server Error')
//       });

//       const req = httpMock.expectOne(`${environment.apiUrl}/reciter`);
//       expect(req.request.method).toBe('GET');
//       // req.flush('test error', errorResponse.error);
//     });
//   });

//   describe('getRecitersList Error Handling', () => {
//     it('should handle error when server returns an error for getRecitersList', () => {
//       const filter: ReciterFilter = { page: 1, limit: 10 };

//       service.getRecitersList(filter).subscribe({
//         next: () => fail('expected an error, not a list of reciters'),
//         error: (error: HttpErrorResponse) => {
//           expect(error.status).toBe(500);
//           expect(error.statusText).toBe('Internal Server Error');
//           expect(error.error).toBe('test error');
//         }
//       });

//       const req = httpMock.expectOne(`${environment.apiUrl}/reciter`);
//       expect(req.request.method).toBe('GET');


//     });
//   });


// });



describe('RecitersService', () => {
  let service: RecitersService;
  let httpTestingController: HttpTestingController;
  const apiUrl = `${environment.apiUrl}/reciter`;

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
