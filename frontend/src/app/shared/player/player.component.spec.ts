import { ComponentFixture, TestBed } from '@angular/core/testing';
import { PlayerComponent } from './player.component';
import { PlayerService } from '../../services/player/player.service';
import { of, Subject } from 'rxjs';
import { ElementRef } from '@angular/core';

describe('PlayerComponent', () => {
  let component: PlayerComponent;
  let fixture: ComponentFixture<PlayerComponent>;
  let playerServiceMock: any;
  let mockPlayTrack$: Subject<string>;
  let mockPauseTrack$: Subject<void>;

  beforeEach(async () => {
    // Mock the PlayerService
    mockPlayTrack$ = new Subject<string>();
    mockPauseTrack$ = new Subject<void>();
    playerServiceMock = {
      playTrack$: mockPlayTrack$.asObservable(),
      pauseTrack$: mockPauseTrack$.asObservable(),
      playTrack: jasmine.createSpy('playTrack'),
      pauseTrack: jasmine.createSpy('pauseTrack'),
      trackEnded: jasmine.createSpy('trackEnded')
    };

    await TestBed.configureTestingModule({
      declarations: [PlayerComponent],
      providers: [
        { provide: PlayerService, useValue: playerServiceMock }
      ]
    })
      .compileComponents();


  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PlayerComponent);
    component = fixture.componentInstance;

    // Mock ElementRef for playerRef
    component.playerRef = new ElementRef(document.createElement('audio'));

    fixture.detectChanges();

    spyOn(component.player, 'play').and.callFake(() => Promise.resolve());
    spyOn(component.player, 'pause');
  });


  afterEach(() => {
    // Complete or unsubscribe from all observables
    mockPlayTrack$.complete();
    mockPauseTrack$.complete();
  });
  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should initialize player from playerRef', () => {
    expect(component.player).toBeTruthy();
    expect(component.player.tagName).toBe('AUDIO');
  });

  it('should play track', () => {

    const testUrl = 'http://test.com/test.mp3';
    component.playTrack(testUrl);
    console.log('component.player.src is ', component.player.src, testUrl);

    expect(component.player.src).toContain(testUrl);
    expect(component.player.play).toHaveBeenCalled();

  });

  it('should pause track', () => {

    // Call the pauseTrack method
    component.pauseTrack();

    // Check if the player's pause method was called
    expect(component.player.pause).toHaveBeenCalled();
  });

  it('should react to playTrack$ observable', () => {
    const testUrl = 'http://test.com/newtrack.mp3';

    mockPlayTrack$.next(testUrl);

    fixture.detectChanges();
    
    expect(component.player.src).toContain(testUrl);
  });

  it('should react to pauseTrack$ observable', () => {
    mockPauseTrack$.next();
    fixture.detectChanges();

    // Expectations for pauseTrack
    expect(component.player.pause).toHaveBeenCalled();
  });

  it('should notify service on track end', () => {
    const testUrl = 'http://test.com/finishedtrack.mp3';
    component.player.src = testUrl;
    component.playerEnded(testUrl);
    expect(playerServiceMock.trackEnded).toHaveBeenCalledWith(testUrl);
  });


});

// ng test --include=src/app/shared/player/player.component.spec.ts