import { SafeUrlPipe } from "./safe-url.pipe";
import { DomSanitizer, SafeResourceUrl } from "@angular/platform-browser";

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
  //   sanitizer.bypassSecurityTrustResourceUrl.and.returnValue(expectedSafeUrl);

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

  // Add more test cases as needed to cover edge cases and other scenarios.
});

 // ng test --include=src/app/shared/pipes/safe-url.pipe.spec.ts
