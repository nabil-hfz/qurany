import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { LibraryModel } from '../../models/library.model';
import { LibraryService } from '../../services/library/library.service';

@Component({
  selector: 'library-grid',
  templateUrl: './library-grid.component.html',
  styleUrls: ['./library-grid.component.scss']
})
export class LibraryGridComponent implements OnInit {
  loading$: Observable<boolean> = of(true);
  values$: Observable<LibraryModel[]> | undefined;
  selectedFile: LibraryModel | null = null;  

  constructor(private service: LibraryService) { }

  ngOnInit(): void {
    this.loading$ = of(true);
    this.values$ = this.service.getLibraryFiles();
    this.values$.subscribe(() => {
      this.loading$ = of(false);
    });
  }

  onCardPressed(value: LibraryModel): void {
    this.selectedFile = value; 
  }

  closeDetails(): void {
    this.selectedFile = null;
  }
}
