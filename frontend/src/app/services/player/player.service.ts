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

  // Observable streams for play, pause, track ended, and current track URL events.
  playTrack$ = this.playTrackSource.asObservable();
  pauseTrack$ = this.pauseTrackSource.asObservable();
  trackEnded$ = this.trackEndedSource.asObservable();
  currentTrackUrl$ = this.currentTrackUrl.asObservable();

  /**
   * Initiates playback of a track with the specified preview URL.
   * @param previewUrl - The preview URL of the track to play.
   */
  playTrack(previewUrl: string) {
    this.playTrackSource.next(previewUrl);
    this.currentTrackUrl.next(previewUrl);
  }

  /**
   * Pauses playback of the track with the specified preview URL.
   * @param previewUrl - The preview URL of the track to pause.
   */
  pauseTrack(previewUrl: string) {
    this.pauseTrackSource.next(previewUrl);
    
    // Clear the current track URL if it's the same as the paused one.
    if (this.currentTrackUrl.value === previewUrl) {
      this.currentTrackUrl.next('');
    }
  }

  /**
   * Notifies when a track with the specified preview URL has ended.
   * @param previewUrl - The preview URL of the track that has ended.
   */
  trackEnded(previewUrl: string) {
    this.trackEndedSource.next(previewUrl);
    
    // Clear the current track URL if it's the same as the ended one.
    if (this.currentTrackUrl.value === previewUrl) {
      this.currentTrackUrl.next('');
    }
  }

  /**
   * Retrieves the URL of the currently playing track, if any.
   * @returns The URL of the currently playing track, or an empty string if none is playing.
   */
  getCurrentTrackUrl(): string {
    return this.currentTrackUrl.value;
  }
}
