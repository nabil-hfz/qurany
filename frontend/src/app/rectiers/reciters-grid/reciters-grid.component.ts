import { Component } from '@angular/core';

import { OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ReciterModel } from '../../models/reciter.model';
import { RecitersService } from '../../services/reciters/reciters.service';

@Component({
  selector: 'reciters-grid',
  templateUrl: './reciters-grid.component.html',
  styleUrl: './reciters-grid.component.scss'
})
export class RecitersGridComponent implements OnInit {

  isLoading = true;

  items: ReciterModel[] = [];

  delayForLoader: number = 200;
  constructor(public service: RecitersService, public router: Router) { }

  ngOnInit(): void {
    const filter = { limit: 100 };

    this.service.getRecitersList(filter).subscribe({
      next: (values: any) => {
        this.items = values.items;
        this.isLoading = false;
      }, error: (err: any) => {
        this.isLoading = false;
        throw err;
      }
    });

  }


  // If the reciter has more than one khatma then we want to display them all first,
  // then the user would select one of them to get the recitations list.
  // Otherwise we will navigate to the recitations list page.
  onCardPressed(value: ReciterModel) {
    const words = value.name.currentValue?.split(' ');
    // if (value.numberOfKhatmat > 1)
    {
      this.router.navigate(['/khatmat-grid', value.id, words?.join('-') || '']);
    }

    // else if (value.numberOfKhatmat == 1) {
    //   this.router.navigate(['/khatma-details', value.id, words?.join('-') || ''], {
    //     queryParams: {
    //       reciterId: value.id,
    //     }
    //   });
    // } else {
    //   alert('This reciter does not have any khatma');
    // }
  }
}


