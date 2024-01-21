import { Component, OnInit } from '@angular/core';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { ActivatedRoute, Router } from '@angular/router';
import { KhatmaModel } from '../../models/khatma.model';
import { KhatmaFilter } from '../../models/filters/khatma.filter';
import { BaseFilter } from '../../models/filters/base.filter';
import { Observable, of } from 'rxjs';

@Component({
  selector: 'khatmat-grid',
  templateUrl: './khatmat-grid.component.html',
  styleUrl: './khatmat-grid.component.scss'
})
export class KhatmatGridComponent implements OnInit {

  loading$: Observable<boolean> = of(true);
  values$: Observable<KhatmaModel[]> | undefined;

  constructor(
    private service: KhatmaService,
    private router: Router,
    private activatedRoute: ActivatedRoute
  ) {}

  ngOnInit(): void {
    // Initialize loading flag to true.
    this.loading$ = of(true);

    // Retrieve Khatma data from the service.
    this.values$ = this.service.getKhatmat();

    // Subscribe to the values$ observable to track loading status.
    this.values$.subscribe((v) => {
      // Once the data is loaded, set the loading flag to false.
      this.loading$ = of(false);
    });
  }

  navigateToForm() {
    // Implement navigation logic to add a new Khatma.
    // Example: this.router.navigate(['/khatma-form']);
  }

  onCardPressed(value: KhatmaModel) {
    // Handle card press event. You can navigate to the details page with appropriate parameters.
    const words = value.name.ar?.split(' ');
    this.router.navigate(['khatma-details', value.id, words?.join('-') || ''], { queryParams: value });
  }
}
