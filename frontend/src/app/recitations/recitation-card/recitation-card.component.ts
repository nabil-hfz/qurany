import { Component, Input, OnInit, OnDestroy } from '@angular/core';
import { RecitationModel } from '../../models/recitation.model';
import { PlayerService } from '../../services/player/player.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'recitation-card',
  templateUrl: './recitation-card.component.html',
  styleUrl: './recitation-card.component.scss'
})
export class RecitationCardComponent  {

  @Input('recitation')
  item!: RecitationModel;
  constructor(private playerService: PlayerService) { }

}
