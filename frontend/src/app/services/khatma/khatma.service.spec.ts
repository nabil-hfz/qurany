import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { KhatmaService } from './khatma.service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { KhatmaModel } from '../../models/khatma.model';
import { throwError, of } from 'rxjs';
import { LocalizedModel } from '../../models/localized.model';

describe('KhatmaService', () => {
  let service: KhatmaService;
  let httpClientSpy: jasmine.SpyObj<HttpClient>;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    httpClientSpy = jasmine.createSpyObj('HttpClient', ['get']);
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [
        KhatmaService,
        { provide: HttpClient, useValue: httpClientSpy }
      ]
    });
    service = TestBed.inject(KhatmaService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  describe('getKhatmat', () => {
    it('should return expected khatmat (HttpClient called once)', () => {
      const expectedKhatmat: KhatmaModel[] = [{
        id: 1, name: { ar: 'Khatma 1', en: 'Khatma 1' } as LocalizedModel,
        totalDownloads: 0,
        totalPlays: 0,
        createdAt: new Date(),

      }, {
        id: 2, name: { ar: 'Khatma 2', en: 'Khatma 2' } as LocalizedModel,
        totalDownloads: 2,
        totalPlays: 2,
        createdAt: new Date(),

      }];

      httpClientSpy.get.and.returnValue(of(expectedKhatmat));

  
      service.getKhatmat().subscribe({
        next: khatmat => expect(khatmat).toEqual(expectedKhatmat),
        error: fail
      });

      // Adjust the expected URL here
      const req = httpMock.expectOne(`${environment.apiUrl}/khatma`);
      expect(req.request.method).toBe('GET');
      req.flush(expectedKhatmat);

  
    });

    // Test for error handling
  });

  // describe('getKhatma', () => {
  //   it('should return expected Khatma by ID(HttpClient called once)', () => {
  //     const khatmaId = 1;
  //     const expectedKhatma: KhatmaModel = {
  //       id: khatmaId, name: { ar: 'Khatma 1', en: 'Khatma 1' } as LocalizedModel,
  //       totalDownloads: 0,
  //       totalPlays: 0,
  //       createdAt: new Date(),

  //     };

  //     httpClientSpy.get.and.returnValue(of(expectedKhatma));

  //    service.getKhatma(khatmaId).subscribe({
  //       next: khatma => expect(khatma).toEqual(expectedKhatma),
  //       error: fail
  //     });

  //     // Adjust the expected URL here
  //     const req = httpMock.expectOne(`${environment.apiUrl}/khatma/${khatmaId}`);
  //     expect(req.request.method).toBe('GET');
  //     req.flush(expectedKhatma);
  //   });
  // });
});

