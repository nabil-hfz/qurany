import { Component, OnInit } from '@angular/core';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { ActivatedRoute, Router } from '@angular/router';
import { KhatmaModel } from '../../models/khatma.model';
import { KhatmaFilter } from '../../models/filters/khatma.filter';

@Component({
  selector: 'khatmat-grid',
  templateUrl: './khatmat-grid.component.html',
  styleUrl: './khatmat-grid.component.css'
})
export class KhatmatGridComponent implements OnInit {

  isLoading = true;

  values: KhatmaModel[] = [];

  delayForLoader: number = 200;
  constructor(
    private service: KhatmaService,
    private router: Router,
    private activatedRoute: ActivatedRoute) {

  }

  ngOnInit(): void {

    let reciterId = this.activatedRoute.snapshot.queryParamMap.get('reciterId');
    let filter = { limit: 100, reciterId: reciterId };

    this.service.getKhatmat(filter).subscribe({
      next: (values: any) => {
        this.values = values.items;
        this.isLoading = false;
      }, error: (err: any) => {
        this.isLoading = false;
        throw err;
      }
    });
  }


  navigateToForm() {
    // this.router.navigate(['/portfolios/add']);
  }


  onCardPressed(value: KhatmaModel) {
    let words = value.name.ar?.split(' ');
    this.router.navigate(['/khatma-details', value.id, words?.join('-') || '']);

  }
}


