import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { LibraryModel } from '../../models/library.model';
import { LibraryService } from '../../services/library/library.service';
import { FileFormComponent } from '../file-form/file-form.component';
import { MatDialog } from '@angular/material/dialog';
import { FileDetailsComponent } from '../file-details/file-details.component';

@Component({
  selector: 'library-grid',
  templateUrl: './library-grid.component.html',
  styleUrls: ['./library-grid.component.scss']
})
export class LibraryGridComponent implements OnInit {
  loading$: Observable<boolean> = of(true);
  values$: Observable<LibraryModel[]> | undefined;
  selectedFile: LibraryModel | null = null;

  constructor(private service: LibraryService, public dialog: MatDialog) { }

  openAddFileDialog() {

    this.dialog.open(FileFormComponent, {
      width: '2000px',

    });
  }

  ngOnInit(): void {
    this.loading$ = of(true);
    this.values$ = this.service.getLibraryFiles();
    this.values$.subscribe(() => {
      this.loading$ = of(false);
    });
  }

  onCardPressed(value: LibraryModel): void {
    this.dialog.open(FileDetailsComponent, {
      width: '100%',
      height: '100%',
      data: value,
      disableClose: false,
    });
    // this.selectedFile = value;
  }

  closeDetails(): void {
    // this.selectedFile = null;
  }
}
