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

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RecitationsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
