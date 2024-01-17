import { TestBed } from '@angular/core/testing';
import { PlayerService } from './player.service';

describe('PlayerService', () => {
  let service: PlayerService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PlayerService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should have initial values for observables', (done) => {
    service.playTrack$.subscribe((previewUrl) => {
      expect(previewUrl).toBe('');
      done();
    });

    service.pauseTrack$.subscribe((previewUrl) => {
      expect(previewUrl).toBe('');
      done();
    });

    service.trackEnded$.subscribe((previewUrl) => {
      expect(previewUrl).toBe('');
      done();
    });

    service.currentTrackUrl$.subscribe((url) => {
      expect(url).toBe('');
      done();
    });
  });

  it('should emit the correct preview URL when playTrack is called', (done) => {
    const previewUrl = 'https://example.com/track.mp3';

    service.playTrack$.subscribe((emittedUrl) => {
      expect(emittedUrl).toBe(previewUrl);
      done();
    });

    service.playTrack(previewUrl);
  });

  it('should emit the correct preview URL when pauseTrack is called', (done) => {
    const previewUrl = 'https://example.com/track.mp3';

    service.pauseTrack$.subscribe((emittedUrl) => {
      expect(emittedUrl).toBe(previewUrl);
      done();
    });

    service.pauseTrack(previewUrl);
  });

  it('should clear current track URL when pauseTrack is called for the current track', () => {
    const previewUrl = 'https://example.com/track.mp3';

    service.playTrack(previewUrl);
    expect(service.getCurrentTrackUrl()).toBe(previewUrl);

    service.pauseTrack(previewUrl);
    expect(service.getCurrentTrackUrl()).toBe('');
  });

  it('should emit the correct preview URL when trackEnded is called', (done) => {
    const previewUrl = 'https://example.com/track.mp3';

    service.trackEnded$.subscribe((emittedUrl) => {
      expect(emittedUrl).toBe(previewUrl);
      done();
    });

    service.trackEnded(previewUrl);
  });

  it('should clear current track URL when trackEnded is called for the current track', () => {
    const previewUrl = 'https://example.com/track.mp3';

    service.playTrack(previewUrl);
    expect(service.getCurrentTrackUrl()).toBe(previewUrl);

    service.trackEnded(previewUrl);
    expect(service.getCurrentTrackUrl()).toBe('');
  });
});

// ng test --include=src/app/services/player/player.service.spec.ts