import { TestBed } from '@angular/core/testing';

import { RecitersService } from './reciters.service';

describe('RecitersService', () => {
  let service: RecitersService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RecitersService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
