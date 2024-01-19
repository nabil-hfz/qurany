import { Component, Input, OnInit } from '@angular/core';
import { RecitationsService } from '../../services/recitations/recitations.service';
import { ActivatedRoute, Router } from '@angular/router';
import { RecitationModel } from '../../models/recitation.model';
import { Observable, of } from 'rxjs';
import { PlayerService } from '../../services/player/player.service';

/**
 * Component representing a list of recitations.
 */
@Component({
  selector: 'recitations-list',
  templateUrl: './recitations-list.component.html',
  styleUrls: ['./recitations-list.component.scss']
})
export class RecitationsListComponent implements OnInit {
  /**
   * Observable that indicates whether the component is loaded or not.
   */
  loaded$: Observable<boolean> = of(true);

  /**
   * Input property that specifies the khatmaId associated with the recitations.
   */
  @Input('khatmaId')
  khatmaId: number | undefined;

  /**
   * Input property that specifies the name of the reciter.
   */
  @Input('reciterName')
  reciterName: string = '';

  /**
   * Array of recitation models to be displayed in the list.
   */
  recitations: RecitationModel[] = [];

  /**
   * Constructor of the RecitationsListComponent.
   * @param service An instance of the RecitationsService used to fetch recitations.
   * @param router An instance of the Angular Router for navigation.
   * @param activatedRoute An instance of the ActivatedRoute for route information.
   * @param playerService An instance of the PlayerService for managing audio playback.
   */
  constructor(
    private service: RecitationsService,
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private playerService: PlayerService) {
  }

  /**
   * Lifecycle hook that is executed when the component is initialized.
   * It loads the recitations based on the provided khatmaId.
   */
  ngOnInit(): void {
    if (this.khatmaId) {
      let params = { limit: 30, params: [{ khatmaId: this.khatmaId }] };

      // Fetch recitations from the service and subscribe to the results.
      this.service.getRecitations(params).subscribe(recitations => {
        this.recitations = recitations;
        this.loaded$ = of(false); // Indicates that the component is now loaded.
      });
    }
  }
}
