import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { LibraryService } from './library.service';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { LibraryModel } from '../../models/library.model';
import { throwError, of } from 'rxjs';
import { BaseFilter } from '../../models/filters/base.filter';
import { LocalizedModel } from '../../models/localized.model';

describe('LibraryService', () => {
  let service: LibraryService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [LibraryService]
    });

    service = TestBed.inject(LibraryService);
    httpMock = TestBed.inject(HttpTestingController);
  });
  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  describe('getLibraryFiles', () => {
    it('should return expected library files (GET request)', () => {
      const mockLibraryFiles: LibraryModel[] = [
        {
          id: 1,
          name: 'Sample Library File',
          language: {
            id: 1,
            name: 'English',
            createdAt: new Date(),
          },
          categories: [
            {
              id: 1,
              name: { ar: 'Category 1', en: 'Category 1' } as LocalizedModel,
              createdAt: new Date(),
            },
            {
              id: 2,
              name: { ar: 'Category 2', en: 'Category 2' } as LocalizedModel,
              createdAt: new Date(),
            }
          ],
          file: 'path/to/file.pdf',
          thumbnail: 'path/to/thumbnail.jpg',
          totalViews: 100,
          totalDownloads: 50,
          description: 'This is a sample library file for testing',
          createdAt: new Date(),
          updatedAt: new Date()
        }
      ];

      service.getLibraryFiles().subscribe(files => {
        expect(files.length).toBeGreaterThan(0);
        expect(files).toEqual(mockLibraryFiles);
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/library?page=0&limit=20`);
      expect(req.request.method).toBe('GET');
      req.flush(mockLibraryFiles);
    });

  });

  describe('getFileDetails', () => {
    it('should return file details for a given ID (GET request)', () => {
      const mockFileDetails: LibraryModel = {
        id: 1,
        name: 'Sample Library File',
        language: {
          id: 1,
          name: 'English',
          createdAt: new Date(),
        },
        categories: [
          {
            id: 1,
            name: { ar: 'Category 1', en: 'Category 1' } as LocalizedModel,
            createdAt: new Date(),
          },
          {
            id: 2,
            name: { ar: 'Category 2', en: 'Category 2' } as LocalizedModel,
            createdAt: new Date(),
          }
        ],
        file: 'path/to/file.pdf',
        thumbnail: 'path/to/thumbnail.jpg',
        totalViews: 100,
        totalDownloads: 50,
        description: 'This is a sample library file for testing',
        createdAt: new Date(),
        updatedAt: new Date()
      };
      const fileId = 1;

      service.getFileDetails(fileId).subscribe(detail => {
        expect(detail).toEqual(mockFileDetails);
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/library/${fileId}`);
      expect(req.request.method).toBe('GET');
      req.flush(mockFileDetails);
    });

  });

  // Error Handling Tests for getLibraryFiles
  describe('getLibraryFiles Error Handling', () => {
    it('should handle error when server returns an error for getLibraryFiles', () => {
      const errorResponse = new HttpErrorResponse({
        error: 'test error',
        status: 500,
        statusText: 'Internal Server Error'
      });
      service.getLibraryFiles().subscribe({
        next: () => fail('expected an error, not library files'),
        error: error => expect(error.originalError.message).toContain('Internal Server Error')
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/library?page=0&limit=20`);
      expect(req.request.method).toBe('GET');
      req.flush('Error loading library files', errorResponse);


    });
  });

  // // Error Handling Tests for getFileDetails
  describe('getFileDetails Error Handling', () => {
    it('should handle error when server returns an error for getFileDetails', () => {
      const fileId = 1;
      const errorResponse = new HttpErrorResponse({
        error: 'test error',
        status: 500,
        statusText: 'Internal Server Error'
      });


      service.getFileDetails(fileId).subscribe({
        next: () => fail('expected an error, not file details'),
        error: error => {
          expect(error.originalError.message).toContain('500 Internal Server Error')
        }
      });

      const req = httpMock.expectOne(`${environment.apiUrl}/library/${fileId}`);
      expect(req.request.method).toBe('GET');
      req.flush('Error loading file details', errorResponse);
    });
  });


});
// ng test --include=src/app/services/library/library.service.spec.ts
