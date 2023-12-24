import { Component, Input, OnInit } from '@angular/core';
import { RecitationsService } from '../../services/recitations/recitations.service';
import { ActivatedRoute, Router } from '@angular/router';
import { RecitationModel } from '../../models/recitation.model';
import { Observable, of } from 'rxjs';
import { PlayerService } from '../../services/player/player.service';

@Component({
  selector: 'recitations-list',
  templateUrl: './recitations-list.component.html',
  styleUrl: './recitations-list.component.scss'
})
export class RecitationsListComponent implements OnInit {
  loaded$: Observable<boolean> = of(true);

  @Input('khatmaId')
  khatmaId: number | undefined;

  @Input('reciterName')
  reciterName: string = '';

  recitations: RecitationModel[] = [];
  constructor(
    private service: RecitationsService,
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private playerService: PlayerService) {
  }

  ngOnInit(): void {
    if (this.khatmaId) {
      let params = { limit: 30, params: [{ khatmaId: this.khatmaId }] };
      this.service.getRecitations(params).subscribe(recitations => {
        this.recitations = recitations;
        this.loaded$ = of(false);
      });

    }
  }


}
