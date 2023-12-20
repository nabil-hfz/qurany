import { TestBed } from '@angular/core/testing';

import { KhatmaService } from './khatma.service';

describe('KhatmaService', () => {
  let service: KhatmaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(KhatmaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
