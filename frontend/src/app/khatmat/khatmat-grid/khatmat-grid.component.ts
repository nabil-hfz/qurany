import { Component, OnInit } from '@angular/core';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { ActivatedRoute, Router } from '@angular/router';
import { KhatmaModel } from '../../models/khatma.model';
import { KhatmaFilter } from '../../models/filters/khatma.filter';
import { BaseFilter } from '../../models/filters/base.filter';

@Component({
  selector: 'khatmat-grid',
  templateUrl: './khatmat-grid.component.html',
  styleUrl: './khatmat-grid.component.css'
})
export class KhatmatGridComponent implements OnInit {

  isLoading = true;

  values: KhatmaModel[] = [];

  constructor(
    private service: KhatmaService,
    private router: Router,
    private activatedRoute: ActivatedRoute) {

  }

  ngOnInit(): void {

    // const reciterId = this.activatedRoute.snapshot.paramMap.get('reciterId');
    // const filter: BaseFilter = {    };
    // console.log('filter is ', filter);

    this.service.getKhatmat( ).subscribe({
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
    const words = value.name.ar?.split(' ');
    this.router.navigate(['khatma-details', value.id, words?.join('-') || '']);

  }
}


