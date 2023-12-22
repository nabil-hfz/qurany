import { TestBed } from '@angular/core/testing';

import { RecitationsService } from './recitations.service';

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
