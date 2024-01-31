import { Component, OnInit, Input, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { PlayerService } from '../../../services/player/player.service';

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
    // Subscribe to changes in the current audio track URL.
    this.currentTrackSub = this.playerService.currentTrackUrl$.subscribe(url => {
      // Update the isPlaying flag based on whether the current track URL matches the input audio URL.
      this.isPlaying = (url === this.audio);
    });
  }

  ngOnDestroy() {
    // Unsubscribe from the currentTrackSub subscription to avoid memory leaks.
    this.currentTrackSub.unsubscribe();
  }

  onPlayOrPause() {
    if (this.audio) {
      // Toggle playback state based on the isPlaying flag.
      this.isPlaying ?
        this.playerService.pauseTrack(this.audio) :
        this.playerService.playTrack(this.audio);
    }
  }

  isBeingPlayed(): boolean {
    return this.isPlaying;
  }
}
