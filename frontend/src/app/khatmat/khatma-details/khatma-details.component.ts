import { Component, OnInit } from '@angular/core';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs';

@Component({
  selector: 'khatma-details',
  templateUrl: './khatma-details.component.html',
  styleUrl: './khatma-details.component.css'
})
export class KhatmaDetailsComponent implements OnInit {
  reciterId = -1;

  constructor(
    private serivce: KhatmaService,
    private activaedRoute: ActivatedRoute,
    private router: Router,
  ) {

  }




  ngOnInit(): void {
    const reciterId = this.activaedRoute.snapshot.queryParamMap.get('reciterId');
    console.log(this.activaedRoute.snapshot.queryParamMap.getAll('reciterId'));
    if (reciterId && Number(reciterId)) {
      this.reciterId = Number(reciterId);
      this.serivce.getAll().pipe(map((value: any) => {

      }));
    }
  }

}
