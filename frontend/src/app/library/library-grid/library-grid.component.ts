import { Component, OnInit } from '@angular/core';
import { LibraryModel } from '../../models/library.model';
import { Observable, of } from 'rxjs';
import { LibraryService } from '../../services/library/library.service';
import { Router } from '@angular/router';

@Component({
  selector: 'library-grid',
  templateUrl: './library-grid.component.html',
  styleUrls: ['./library-grid.component.scss']
})
export class LibraryGridComponent implements OnInit {
  // Observable to track loading status
  loading$: Observable<boolean> = of(true);

  // Observable to store library data
  values$: Observable<LibraryModel[]> | undefined;

  constructor(private service: LibraryService, private router: Router) {}

  ngOnInit(): void {
    // Set loading status to true
    this.loading$ = of(true);

    // Fetch library data from the service
    this.values$ = this.service.getLibraryFiles();

    // Subscribe to the library data observable
    this.values$.subscribe((libraryData) => {
      // Set loading status to false when data is received
      this.loading$ = of(false);
    });
  }


  navigateToForm() {
    // Example: this.router.navigate(['/portfolios/add']);
  }

  // Function to handle card click event
  onCardPressed(value: LibraryModel) {
    this.router.navigate(['/file-details', value.id]); 
  }
}
