import { SafeUrlPipe } from "./safe-url.pipe";
import { DomSanitizer, SafeResourceUrl } from "@angular/platform-browser";
import { TestBed } from '@angular/core/testing';

class MockDomSanitizer {
  bypassSecurityTrustResourceUrl(url: string) {
    return 'safeUrl:' + url; // Mocked behavior
  }
}

describe("SafeUrlPipe", () => {
  let pipe: SafeUrlPipe;
  let sanitizer: DomSanitizer;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        SafeUrlPipe,
        { provide: DomSanitizer, useClass: MockDomSanitizer }
      ]
    });
    pipe = TestBed.inject(SafeUrlPipe);
    sanitizer = TestBed.inject(DomSanitizer);
  });

  it("should create an instance of the pipe", () => {
    expect(pipe).toBeTruthy();
  });
  
  it('should transform URL into SafeResourceUrl', () => {
    const url = 'https://example.com';
    spyOn(sanitizer, 'bypassSecurityTrustResourceUrl').and.callThrough();

    const safeUrl = pipe.transform(url);

    expect(sanitizer.bypassSecurityTrustResourceUrl).toHaveBeenCalledWith(url);
    expect(safeUrl).toEqual('safeUrl:' + url);
  });

});

// ng test --include=src/app/shared/pipes/safe-url.pipe.spec.ts
