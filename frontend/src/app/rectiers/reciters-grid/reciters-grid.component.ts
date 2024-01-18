import { Component } from '@angular/core';
import { OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ReciterModel } from '../../models/reciter.model';
import { RecitersService } from '../../services/reciters/reciters.service';

/**
 * This component displays a grid of Quranic reciters and allows navigation to their details.
 */
@Component({
  selector: 'reciters-grid',
  templateUrl: './reciters-grid.component.html',
  styleUrls: ['./reciters-grid.component.scss']
})
export class RecitersGridComponent implements OnInit {

  /**
   * Indicates whether the component is in the loading state.
   */
  isLoading = true;

  /**
   * An array of reciters to be displayed in the grid.
   */
  items: ReciterModel[] = [];

  /**
   * Delay time in milliseconds before showing the loader.
   */
  delayForLoader: number = 200;

  /**
   * Constructor for the RecitersGridComponent.
   *
   * @param service - The service responsible for fetching reciters' data.
   * @param router - The Angular router for navigation.
   */
  constructor(public service: RecitersService, public router: Router) { }

  /**
   * Angular lifecycle hook called when the component is initialized.
   * It fetches the list of reciters and sets up the component.
   */
  ngOnInit(): void {
    const filter = { limit: 100 };

    this.service.getRecitersList(filter).subscribe({
      next: (values: any) => {
        this.items = values.items;
        this.isLoading = false;
      },
      error: (err: any) => {
        this.isLoading = false;
        throw err;
      }
    });
  }

  /**
   * Event handler when a reciter card is pressed.
   *
   * @param value - The selected reciter.
   */
  onCardPressed(value: ReciterModel) {
    const words = value.name.currentValue?.split(' ');

    // Check if the reciter has more than one Khatma (Quranic reading).
    if (value.numberOfKhatmat > 1) {
      this.router.navigate(['/khatmat-grid', value.id, words?.join('-') || '']);
    }
    // You can add more conditions for other cases if needed.
    // else if (value.numberOfKhatmat == 1) {
    //   this.router.navigate(['/khatma-details', value.id, words?.join('-') || ''], {
    //     queryParams: {
    //       reciterId: value.id,
    //     }
    //   });
    // } else {
    //   alert('This reciter does not have any Khatma (Quranic reading).');
    // }
  }
}
