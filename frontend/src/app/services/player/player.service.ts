import { Injectable } from '@angular/core';
import { Subject, BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PlayerService {
  private playTrackSource = new Subject<string>();
  private pauseTrackSource = new Subject<string>();
  private trackEndedSource = new Subject<string>();
  protected currentTrackUrl = new BehaviorSubject<string>('');

  playTrack$ = this.playTrackSource.asObservable();
  pauseTrack$ = this.pauseTrackSource.asObservable();
  trackEnded$ = this.trackEndedSource.asObservable();
  currentTrackUrl$ = this.currentTrackUrl.asObservable();

  playTrack(previewUrl: string) {
    this.playTrackSource.next(previewUrl);
    this.currentTrackUrl.next(previewUrl);
  }

  pauseTrack(previewUrl: string) {
    this.pauseTrackSource.next(previewUrl);
    // Clear the current track if it's the same as the paused one
    if (this.currentTrackUrl.value === previewUrl) {
      this.currentTrackUrl.next('');
    }
  }

  trackEnded(previewUrl: string) {
    this.trackEndedSource.next(previewUrl);
    if (this.currentTrackUrl.value === previewUrl) {
      this.currentTrackUrl.next('');
    }
  }
  getCurrentTrackUrl(): string {
    return this.currentTrackUrl.value;
  }
}
