import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { PlayerService } from '../../../services/player/player.service';

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.scss'],
})
export class PlayerComponent implements OnInit {
  @ViewChild('player', { static: true }) playerRef!: ElementRef<HTMLAudioElement>;
  player!: HTMLAudioElement;

  constructor(private playerService: PlayerService) {
    // Subscribe to playTrack$ and pauseTrack$ observables from PlayerService.
    // These observables are used to control track playback.
    this.playerService.playTrack$.subscribe(previewUrl => {
      this.playTrack(previewUrl);
    });

    this.playerService.pauseTrack$.subscribe(() => {
      this.pauseTrack();
    });
  }

  ngOnInit() {
    // Initialize the player element and add event listeners.
    this.player = this.playerRef.nativeElement;

    // Add an event listener for the 'play' event to notify PlayerService when a track is played.
    this.player.addEventListener('play', () => {
      this.playerService.playTrack(this.player.src);
    });

    // Add an event listener for the 'pause' event to notify PlayerService when a track is paused.
    this.player.addEventListener('pause', () => {
      this.playerService.pauseTrack(this.player.src);
    });
  }

  playTrack(previewUrl: string) {
    // Check if the player source is different from the provided previewUrl, and set it if needed.
    if (this.player.src !== previewUrl) {
      this.player.src = previewUrl;
    }

    // Play the track.
    this.player.play();
  }

  pauseTrack() {
    // Pause the currently playing track.
    this.player.pause();
  }

  playerEnded(previewUrl: string) {
    // Notify PlayerService when a track has ended.
    this.playerService.trackEnded(previewUrl);
  }
}
