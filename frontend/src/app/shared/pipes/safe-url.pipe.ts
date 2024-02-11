import { Pipe, PipeTransform } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

/**
 * Custom Angular pipe that transforms a URL into a safe resource URL using DomSanitizer.
 * This pipe is used to bypass security restrictions for rendering trusted URLs in the application.
 */
@Pipe({
  name: 'safeUrl'
})
export class SafeUrlPipe implements PipeTransform {
  /**
   * Constructor for the SafeUrlPipe class.
   * @param {DomSanitizer} sanitizer - The Angular DomSanitizer service for safe URL transformation.
   */
  constructor(private sanitizer: DomSanitizer) {}

  /**
   * Transforms a URL into a safe resource URL.
   * @param {string} url - The URL to be transformed into a safe resource URL.
   * @returns {SafeResourceUrl} - The safe resource URL that can be rendered in the application.
   */
  transform(url: string): SafeResourceUrl {
    // Use DomSanitizer to bypass security and create a safe resource URL
    return this.sanitizer.bypassSecurityTrustResourceUrl(url);
  }
}
