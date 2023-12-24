import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { PlayerService } from '../../services/player/player.service';

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.scss'],
})
export class PlayerComponent implements OnInit {
  @ViewChild('player', { static: true }) playerRef!: ElementRef<HTMLAudioElement>;
  player!: HTMLAudioElement;

  constructor(private playerService: PlayerService) {
    this.playerService.playTrack$.subscribe(previewUrl => {
      this.playTrack(previewUrl);
    });

    this.playerService.pauseTrack$.subscribe(() => {
      this.pauseTrack();
    });
  }

  ngOnInit() {

    this.player = this.playerRef.nativeElement;

    this.player.addEventListener('play', (value) => {
      this.playerService.playTrack(this.player.src);
    });

    this.player.addEventListener('pause', (value,) => {
      this.playerService.pauseTrack(this.player.src);
    });
  }


  playTrack(previewUrl: string) {
    if (this.player.src != previewUrl)
      this.player.src = previewUrl;

    this.player.play();
  }

  pauseTrack() {
    this.player.pause();
  }

  playerEnded(previewUrl: string) {
    this.playerService.trackEnded(previewUrl);
  }
}
