import { Component } from '@angular/core';

@Component({
  selector: 'file-details',
  templateUrl: './file-details.component.html',
  styleUrls: ['./file-details.component.scss']
})
export class FileDetailsComponent {
  fileUrl: string = '';
  fileType: string = '';

  constructor() {}

  loadFile(url: string): void {
    this.fileUrl = url;
    this.fileType = url.split('.').pop()?.toLowerCase() || '';
  }

  isPDF(): boolean {
    return this.fileType === 'pdf';
  }

  // Add more methods if needed for different file types
}
