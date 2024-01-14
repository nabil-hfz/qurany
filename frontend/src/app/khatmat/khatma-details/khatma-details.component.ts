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
    private serivce: KhatmaService,
    private activaedRoute: ActivatedRoute,
    private router: Router,
  ) {

  }




  ngOnInit() {
    const value = this.activaedRoute.snapshot.queryParamMap.get('value');

    
    console.log(value);
    const khatmaId = this.activaedRoute.snapshot.paramMap.get('khatmaId');
    console.log('KhatmaDetailsComponent is  khatmaId ', khatmaId);

    if (khatmaId && Number(khatmaId)) {
      this.khatmaId = Number(khatmaId);
      try {

        console.log('Calling getKhatma ', this.khatmaId);

        this.serivce.getKhatma(this.khatmaId).pipe(
          map((response) => {
            // console.log('response format is ', response);
            return response;
          }),

        ).subscribe((v) => console.info(v),);
      } catch (err) {
        console.error('response err is ', err);

      }
    }
  }

}
