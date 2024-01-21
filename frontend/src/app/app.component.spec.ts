import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { AppComponent } from './app.component';
import { ItunesService } from './services/itunes/itunes.service';
import { MatSidenavModule } from '@angular/material/sidenav';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatListModule } from '@angular/material/list';
import { MatToolbarModule } from '@angular/material/toolbar';
import { PlayerComponent } from './shared/player/player.component';
import { Subject } from 'rxjs';
import { PlayerService } from './services/player/player.service';

describe('AppComponent', () => {
  let fixture: ComponentFixture<AppComponent>;
  let app: AppComponent;
  let playerServiceMock: any;
  let mockPlayTrack$: Subject<string>;
  let mockPauseTrack$: Subject<void>;

  beforeEach(async () => {

    mockPlayTrack$ = new Subject<string>();
    mockPauseTrack$ = new Subject<void>();
    playerServiceMock = {
      playTrack$: mockPlayTrack$.asObservable(),
      pauseTrack$: mockPauseTrack$.asObservable(),
      playTrack: jasmine.createSpy('playTrack'),
      pauseTrack: jasmine.createSpy('pauseTrack'),
      trackEnded: jasmine.createSpy('trackEnded')
    };
    TestBed.configureTestingModule({
      declarations: [AppComponent, PlayerComponent],
      imports: [
        RouterTestingModule,
        MatSidenavModule,
        BrowserAnimationsModule,
        MatListModule,
        MatToolbarModule,
      ],
      providers: [
        ItunesService,
        { provide: PlayerService, useValue: playerServiceMock }
      ]
    });

    fixture = TestBed.createComponent(AppComponent);
    app = fixture.componentInstance;
  });

  it('should create the app', () => {
    expect(app).toBeTruthy();
  });

  it(`should have as title 'kawtharuna'`, () => {
    expect(app.title).toEqual('kawtharuna');
  });

  // it('should render title in a h1 tag', () => {
  //   fixture.detectChanges();
  //   const compiled = fixture.nativeElement;
  //   expect(compiled.querySelector('h1').textContent).toContain('kawtharuna');
  // });
});
