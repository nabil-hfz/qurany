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
  ) {

  }

  ngOnInit(): void {
    this.loading$ = of(true);

    this.values$ = this.service.getKhatmat();
    this.values$.subscribe((v) => {
      this.loading$ = of(false);
    })
  }


  navigateToForm() {
    // this.router.navigate(['/portfolios/add']);
  }


  onCardPressed(value: KhatmaModel) {
    const words = value.name.ar?.split(' ');
    this.router.navigate(['khatma-details', value.id, words?.join('-') || ''], { queryParams: value });
  }
}


