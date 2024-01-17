import { Component } from '@angular/core';
import { LibraryModel } from '../../models/library.model';
import { Observable, of } from 'rxjs';
// import { Router } from '@angular/router';
import { LibraryService } from '../../services/library/library.service';

@Component({
  selector: 'library-grid',
  templateUrl: './library-grid.component.html',
  styleUrl: './library-grid.component.scss'
})
export class LibraryGridComponent {
  loading$: Observable<boolean> = of(true);


  values$: Observable<LibraryModel[]> | undefined;

  constructor(
    private service: LibraryService,
    // private router: Router,
    // private activatedRoute: ActivatedRoute
  ) {

  }

  ngOnInit(): void {
    this.loading$ = of(true);

    this.values$ = this.service.getLibraryFiles();
    this.values$.subscribe((v) => {
      this.loading$ = of(false);
    })
  }


  navigateToForm() {
    // this.router.navigate(['/portfolios/add']);
  }


  onCardPressed(value: LibraryModel) {
    // const words = value.name.ar?.split(' ');
    // this.router.navigate(['khatma-details', value.id, words?.join('-') || ''], { queryParams: value });
  }
}
