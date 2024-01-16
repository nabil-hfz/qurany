import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { RecitationsService } from './recitations.service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { RecitationModel, RecitationTypes } from '../../models/recitation.model';
import { throwError, of } from 'rxjs';
import { BaseFilter } from '../../models/filters/base.filter';
import { LocalizedModel } from '../../models/localized.model';
import { ReciterModel } from '../../models/reciter.model';
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

  afterEach(() => {
    httpMock.verify();
  });

  describe('getRecitations', () => {
    it('should return expected recitations (GET request)', () => {
      const mockRecitations: RecitationModel[] = [
        {
          id: 1,
          title: {
            ar: 'التلاوة 1',
            en: 'Recitation 1',
          } as LocalizedModel,
          image: 'path/to/image.jpg',
          audio: 'path/to/audio.mp3',
          reciter: {
            id: 1,
            name: {
              ar: 'القارئ 1',
              en: 'Reciter 1',
            } as LocalizedModel,
            bio: {
              ar: 'السيرة الذاتية للقارئ',
              en: 'Reciter biography',
            } as LocalizedModel,
            image: 'path/to/reciter-image.jpg',
            recitationTypes: [RecitationTypes.Hafs, RecitationTypes.Shoaba],
            totalPlays: 100,
            totalDownloads: 50,
            numberOfKhatmat: 5
          } as ReciterModel,
          recitationType: RecitationTypes.Hafs,
          khatmaId: 1,
          sequence: 5,
          totalDownloads: 10,
          totalPlays: 20,
          duration: 180,
          createdAt: new Date(),
          updatedAt: new Date()
        },
        {
          id: 2,
          title: {
            ar: 'التلاوة 2',
            en: 'Recitation 2',
          } as LocalizedModel,
          image: 'path/to/image.jpg',
          audio: 'path/to/audio.mp3',
          reciter: {
            id: 2,
            name: {
              ar: 'القارئ 2',
              en: 'Reciter 2',
            } as LocalizedModel,
            bio: {
              ar: 'السيرة الذاتية للقارئ',
              en: 'Reciter biography',
            } as LocalizedModel,
            image: 'path/to/reciter-image.jpg',
            recitationTypes: [RecitationTypes.Hafs],
            totalPlays: 100,
            totalDownloads: 50,
            numberOfKhatmat: 5
          } as ReciterModel,
          recitationType: RecitationTypes.Hafs,
          khatmaId: 2,
          sequence: 3,
          totalDownloads: 10,
          totalPlays: 20,
          duration: 180,
          createdAt: new Date(),
          updatedAt: new Date()
        }
      ];

      service.getRecitations().subscribe(recitations => {
        expect(recitations.length).toBeGreaterThan(0);
        expect(recitations).toEqual(mockRecitations);
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/recitation?page=0&limit=20`);
      expect(req.request.method).toBe('GET');
      req.flush(mockRecitations);
    });

  });

  it('should return recitation details for a given ID (GET request)', () => {
    const mockRecitationDetails: RecitationModel = {
      id: 1,
      title: {
        ar: 'التلاوة 1',
        en: 'Recitation 1',
      } as LocalizedModel,
      image: 'path/to/image.jpg',
      audio: 'path/to/audio.mp3',
      reciter: {
        id: 1,
        name: {
          ar: 'القارئ 1',
          en: 'Reciter 1',
        } as LocalizedModel,
        bio: {
          ar: 'السيرة الذاتية للقارئ',
          en: 'Reciter biography',
        } as LocalizedModel,
        image: 'path/to/reciter-image.jpg',
        recitationTypes: [RecitationTypes.Hafs, RecitationTypes.Shoaba],
        totalPlays: 100,
        totalDownloads: 50,
        numberOfKhatmat: 5
      } as ReciterModel,
      recitationType: RecitationTypes.Hafs,
      khatmaId: 1,
      sequence: 5,
      totalDownloads: 10,
      totalPlays: 20,
      duration: 180,
      createdAt: new Date(),
      updatedAt: new Date()
    };
    const recitationId = 1;

    service.getRecitation(recitationId).subscribe(detail => {
      expect(detail).toEqual(mockRecitationDetails);
    });

    const req = httpMock.expectOne(`${environment.apiUrl}/recitation/${recitationId}`);
    expect(req.request.method).toBe('GET');
    req.flush(mockRecitationDetails);
  });



  // Error Handling Tests for getRecitations
  describe('getRecitations Error Handling', () => {
    it('should handle error when server returns an error for getRecitations', () => {
      const errorResponse = new HttpErrorResponse({
        error: 'test error',
        status: 500,
        statusText: 'Internal Server Error'
      });

      service.getRecitations().subscribe({
        next: () => fail('expected an error, not recitations'),
        error: error => {
          expect(error.originalError.message).toContain('Internal Server Error')}
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/recitation?page=0&limit=20`);
      expect(req.request.method).toBe('GET');
      req.flush('Error loading recitations', errorResponse);
    });

  });

});
// ng test --include=src/app/services/recitations/recitations.service.spec.ts
