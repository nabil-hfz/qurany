import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RecitationCardComponent } from './recitation-card.component';
import { RecitationModel, RecitationTypes } from '../../models/recitation.model';
import { PlayerService } from '../../services/player/player.service';
import { MatCardModule } from '@angular/material/card';
import { LocalizedModel } from '../../models/localized.model';
import { ReciterModel } from '../../models/reciter.model';
import { TrackControlComponent } from '../../shared/track-control/track-control.component';

describe('RecitationCardComponent', () => {
  let component: RecitationCardComponent;
  let mockRecitation: RecitationModel;
  let fixture: ComponentFixture<RecitationCardComponent>;


  // Create a mock RecitationModel for testing.
  const title1 = new LocalizedModel();
  title1.ar = 'تلاوة 1';
  title1.en = 'Recitation 1';


  let dummyReciter1: ReciterModel;
  const localizedModel = new LocalizedModel();
  localizedModel.ar = 'الشيخ أحمد';
  localizedModel.en = 'Sheikh Ahmed';

  const bio = new LocalizedModel();
  bio.ar = 'الشيخ أحمد هو مقرئ مشهور بقراءته العذبة والمميزة.';
  bio.en = 'Sheikh Ahmed is a famous reciter known for his beautiful and unique recitation.';
  dummyReciter1 = {
    id: 1,
    createdAt: new Date(),
    updatedAt: new Date(),
    name: localizedModel,
    bio: bio,
    image: 'https://example.com/images/sheikh_ahmed.png',
    recitationTypes: [RecitationTypes.Hafs],
    totalPlays: 1000,
    totalDownloads: 500,
    numberOfKhatmat: 5,
  };
  mockRecitation = new RecitationModel();

  mockRecitation.id = 1;
  mockRecitation.title = title1;
  mockRecitation.image = 'image1.jpg';
  mockRecitation.audio = 'audio1.mp3';
  mockRecitation.reciter = dummyReciter1;
  mockRecitation.recitationType = RecitationTypes.Hafs;
  mockRecitation.khatmaId = 1;
  mockRecitation.sequence = 1;
  mockRecitation.totalDownloads = 100;
  mockRecitation.totalPlays = 50;
  mockRecitation.duration = 120;
  mockRecitation.createdAt = new Date();


  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [RecitationCardComponent, TrackControlComponent], 
      providers: [PlayerService],
      imports: [MatCardModule],
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RecitationCardComponent);
    component = fixture.componentInstance;
    component.item = mockRecitation;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should display recitation title', () => {
    const titleElement = fixture.nativeElement.querySelector('mat-card-title');
    expect(titleElement.textContent).toContain('Recitation 1');
  });

  // it('should display total plays and downloads', () => {
  //   // Create a <mat-card> element and append it to the fixture's native element.
  //   const matCardElement = document.createElement('mat-card');
  //   fixture.nativeElement.appendChild(matCardElement);
  
  //   // Now, query the elements within the <mat-card> element.
  //   const playsSubtitleElement = matCardElement.querySelector('item-subtitle:nth-child(1)');
  //   const downloadsSubtitleElement = matCardElement.querySelector('item-subtitle:nth-child(2)');
  
  //   expect(playsSubtitleElement?.textContent).toContain('50 Times played');
  //   expect(downloadsSubtitleElement?.textContent).toContain('100 Times downloaded');
  // });

  // it('should render track control with audio URL', () => {
  //   const trackControl = fixture.nativeElement.querySelector('track-control');
  //   expect(trackControl).toBeTruthy();
  //   expect(trackControl.getAttribute('audioUrl')).toBe('audio1.mp3');
  // });

});

// ng test --include=src/app/recitations/recitation-card/recitation-card.component.spec.ts
