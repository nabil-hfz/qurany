import { Component, OnInit, Input, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { PlayerService } from '../../services/player/player.service';

@Component({
  selector: 'track-control',
  templateUrl: './track-control.component.html',
  styleUrls: ['./track-control.component.scss'],
})
export class TrackControlComponent implements OnInit, OnDestroy {

  @Input('audioUrl')
  public audio: string | undefined;

  isPlaying = false;
  private currentTrackSub!: Subscription;

  constructor(private playerService: PlayerService) { }

  ngOnInit() {
    this.currentTrackSub = this.playerService.currentTrackUrl$.subscribe(url => {
      this.isPlaying = (url === this.audio);
    });
  }

  ngOnDestroy() {
    this.currentTrackSub.unsubscribe();
  }

  onPlayOrPause() {
    if (this.audio) {
      this.isPlaying ?
        this.playerService.pauseTrack(this.audio) :
        this.playerService.playTrack(this.audio);
    }
  }

  isBeingPlayed(): boolean {
    return this.isPlaying;
  }
}
