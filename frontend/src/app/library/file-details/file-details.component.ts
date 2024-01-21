import { Component, EventEmitter, Input, Output } from '@angular/core';
import { LibraryModel } from '../../models/library.model';

@Component({
  selector: 'file-details',
  templateUrl: './file-details.component.html',
  styleUrls: ['./file-details.component.scss']
})
export class FileDetailsComponent {
  @Input() file: LibraryModel | null = null;
  @Output() close = new EventEmitter<void>();
  
  // Add additional properties as needed for viewer state
  currentPage: number = 1;
  totalPages: number = 0; // You will need to set this appropriately

  onClose() {
    this.close.emit();
  }

  // Add methods for controlling the viewer
  onNextPage() {
    // Increment currentPage, update viewer
  }

  onPreviousPage() {
    // Decrement currentPage, update viewer
  }

  // You will need to implement how to determine if a file is a PDF
  isPDF(): boolean {

    // Placeholder implementation
    return this.file?.file.match('pdf') != null;
  }

  constructor() {}
}
