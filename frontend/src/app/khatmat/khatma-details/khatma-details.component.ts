import { Component, OnInit } from '@angular/core';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs';

@Component({
  selector: 'khatma-details',
  templateUrl: './khatma-details.component.html',
  styleUrl: './khatma-details.component.scss'
})
export class KhatmaDetailsComponent implements OnInit {
  khatmaId = -1;
  reciterName = 'khatma';

  constructor(
    private service: KhatmaService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    // Retrieve query parameters and route parameters.
    const value = this.activatedRoute.snapshot.queryParamMap.get('value');
    const khatmaId = this.activatedRoute.snapshot.paramMap.get('khatmaId');

    // Check if a valid khatmaId is provided in the route parameters.
    if (khatmaId && Number(khatmaId)) {
      this.khatmaId = Number(khatmaId);
      try {
        // Fetch Khatma details using the service based on the khatmaId.
        this.service.getKhatma(this.khatmaId).pipe(
          map((response) => {
            // Process the response data here if needed.
            return response;
          })
        ).subscribe((khatmaDetails) => {
          // Handle the fetched Khatma details as needed.
          console.info(khatmaDetails);
        });
      } catch (err) {
        // Handle any errors that may occur during the data retrieval process.
        console.error('Error:', err);
      }
    }
  }
}
