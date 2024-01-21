import { Component, Input } from '@angular/core';
import { RecitationModel } from '../../models/recitation.model';
import { PlayerService } from '../../services/player/player.service';

/**
 * Component representing a card for displaying recitation details.
 */
@Component({
  selector: 'recitation-card',
  templateUrl: './recitation-card.component.html',
  styleUrls: ['./recitation-card.component.scss']
})
export class RecitationCardComponent {
  /**
   * Input property that represents the recitation data to be displayed in the card.
   */
  @Input('recitation')
  item!: RecitationModel;

  /**
   * Constructor of the RecitationCardComponent.
   * @param playerService An instance of the PlayerService for managing audio playback.
   */
  constructor(private playerService: PlayerService) { }
}
