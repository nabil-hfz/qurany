import { Component, Input, OnInit } from '@angular/core';
import { RecitationsService } from '../../services/recitations/recitations.service';
import { ActivatedRoute, Router } from '@angular/router';
import { RecitationModel } from '../../models/recitation.model';

@Component({
  selector: 'app-recitations-list',
  templateUrl: './recitations-list.component.html',
  styleUrl: './recitations-list.component.css'
})
export class RecitationsListComponent implements OnInit {

  isLoading : boolean = false;

  @Input('khatmaId')
  khatmaId: number | undefined;

  recitations: RecitationModel[] = [];
  constructor(
    private service: RecitationsService,
    private router: Router,
    private activatedRoute: ActivatedRoute) {
  }
  ngOnInit(): void {
    if (this.khatmaId) {
      let params = { limit: 30, params: [{ khatmaId: this.khatmaId }] };
      this.service.getRecitations(params).subscribe(recitations => {
        this.recitations = recitations;
        // console.log(recitations);
      });

    }
  }

}
