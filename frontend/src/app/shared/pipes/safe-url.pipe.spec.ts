import { SafeUrlPipe } from "./safe-url.pipe";
import { DomSanitizer, SafeResourceUrl } from "@angular/platform-browser";
import { TestBed } from '@angular/core/testing';

describe("SafeUrlPipe", () => {
  let pipe: SafeUrlPipe;
  let sanitizer: DomSanitizer;

  beforeEach(() => {
    sanitizer = jasmine.createSpyObj("DomSanitizer", ["bypassSecurityTrustResourceUrl"]);
    pipe = new SafeUrlPipe(sanitizer);
  });

  it("should create an instance of the pipe", () => {
    expect(pipe).toBeTruthy();
  });


  // it("should call DomSanitizer's bypassSecurityTrustResourceUrl with the provided URL", () => {
  //   const url = "https://example.com";
  //   const expectedSafeUrl: SafeResourceUrl = {} as SafeResourceUrl; // Mock SafeResourceUrl

  //   // Mock DomSanitizer's bypassSecurityTrustResourceUrl method
  //   // spyOn(sanitizer, 'bypassSecurityTrustResourceUrl').and.returnValue(expectedSafeUrl);
  //   // sanitizer.bypassSecurityTrustResourceUrl.and.returnValue(expectedSafeUrl);

  //   const result = pipe.transform(url);

  //   expect(sanitizer.bypassSecurityTrustResourceUrl).toHaveBeenCalledWith(url);
  //   expect(result).toBe(expectedSafeUrl);
  // });

  // it("should return null when the provided URL is null", () => {
  //   const url = null;
  //   const expectedSafeUrl: SafeResourceUrl = {} as SafeResourceUrl; // Mock SafeResourceUrl

  //   // Mock DomSanitizer's bypassSecurityTrustResourceUrl method
  //   sanitizer.bypassSecurityTrustResourceUrl.and.returnValue(expectedSafeUrl);

  //   const result = pipe.transform(url);

  //   expect(sanitizer.bypassSecurityTrustResourceUrl).not.toHaveBeenCalled();
  //   expect(result).toBeNull();
  // });

  // it("should return null when the provided URL is empty", () => {
  //   const url = "";
  //   const expectedSafeUrl: SafeResourceUrl = {} as SafeResourceUrl; // Mock SafeResourceUrl

  //   // Mock DomSanitizer's bypassSecurityTrustResourceUrl method
  //   sanitizer.bypassSecurityTrustResourceUrl.and.returnValue(expectedSafeUrl);

  //   const result = pipe.transform(url);

  //   expect(sanitizer.bypassSecurityTrustResourceUrl).not.toHaveBeenCalled();
  //   expect(result).toBeNull();
  // });

});


describe('SafeUrlPipe', () => {
  let pipe: SafeUrlPipe;
  let sanitizer: DomSanitizer;

  beforeEach(() => {
    TestBed.configureTestingModule({

      providers: [SafeUrlPipe, DomSanitizer]
    });

    pipe = TestBed.inject(SafeUrlPipe);
    sanitizer = TestBed.inject(DomSanitizer);
  });

  it('create an instance', () => {
    expect(pipe).toBeTruthy();
  });

  // it('should transform URL into SafeResourceUrl', () => {
  //   const url = 'https://example.com';
  //   // Spy on the bypassSecurityTrustResourceUrl method to return a mock SafeResourceUrl
  //   spyOn(sanitizer, 'bypassSecurityTrustResourceUrl').and.returnValue('safeUrl');
  //   const safeUrl = pipe.transform(url);
  //   // Expect the sanitizer to have been called with the URL
  //   expect(sanitizer.bypassSecurityTrustResourceUrl).toHaveBeenCalledWith(url);
  //   // Expect the result to be a 'safeUrl' (or whatever your mock returns)
  //   expect(safeUrl).toEqual('safeUrl');
  // });


});

// ng test --include=src/app/shared/pipes/safe-url.pipe.spec.ts
