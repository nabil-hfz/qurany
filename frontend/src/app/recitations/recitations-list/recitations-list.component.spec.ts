import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute, Router } from '@angular/router';
import { of, take } from 'rxjs';
import { RecitationModel, RecitationTypes } from '../../models/recitation.model';
import { RecitationsListComponent } from './recitations-list.component';
import { RecitationsService } from '../../services/recitations/recitations.service';
import { PlayerService } from '../../services/player/player.service';
import { LocalizedModel } from '../../models/localized.model';
import { ReciterModel } from '../../models/reciter.model';
import { KawtharunaAppBarComponent } from '../../shared/components/kawtharuna-app-bar/kawtharuna-app-bar.component';
import { ItunesService } from '../../services/itunes/itunes.service';
import { MatToolbarModule } from '@angular/material/toolbar';

describe('RecitationsListComponent', () => {
  let component: RecitationsListComponent;
  let fixture: ComponentFixture<RecitationsListComponent>;
  let recitationsService: jasmine.SpyObj<RecitationsService>;
  let itunesServiceMock: ItunesService;

  const title1 = new LocalizedModel();
  title1.ar = 'تلاوة 1';
  title1.en = 'Recitation 1';

  const title2 = new LocalizedModel();
  title2.ar = 'تلاوة 2';
  title2.en = 'Recitation 2';

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
  const recitationData: RecitationModel[] = [
    { id: 1, title: title1, image: 'image1.jpg', audio: 'audio1.mp3', reciter: dummyReciter1, recitationType: RecitationTypes.Hafs, khatmaId: 1, sequence: 1, totalDownloads: 100, totalPlays: 50, duration: 120, createdAt: new Date() },
    { id: 2, title: title2, image: 'image2.jpg', audio: 'audio2.mp3', reciter: dummyReciter1, recitationType: RecitationTypes.Shoaba, khatmaId: 1, sequence: 2, totalDownloads: 80, totalPlays: 40, duration: 90, createdAt: new Date() },

  ];

  beforeEach(() => {
    const recitationsServiceSpy = jasmine.createSpyObj('RecitationsService', ['getRecitations']);
    const routerSpy = jasmine.createSpyObj('Router', ['navigate']);
    const activatedRouteSpy = jasmine.createSpyObj('ActivatedRoute', [], { snapshot: { paramMap: { get: (key: string) => '1' } } });
    const playerServiceSpy = jasmine.createSpyObj('PlayerService', ['playRecitation']);

    TestBed.configureTestingModule({
      imports: [MatToolbarModule],
      declarations: [RecitationsListComponent, KawtharunaAppBarComponent],
      providers: [
        { provide: RecitationsService, useValue: recitationsServiceSpy },
        { provide: Router, useValue: routerSpy },
        { provide: ActivatedRoute, useValue: activatedRouteSpy },
        { provide: PlayerService, useValue: playerServiceSpy },
        { provide: ItunesService, useValue: itunesServiceMock }

      ]
    });

    recitationsService = TestBed.inject(RecitationsService) as jasmine.SpyObj<RecitationsService>;
    recitationsService.getRecitations.and.returnValue(of(recitationData));

    fixture = TestBed.createComponent(RecitationsListComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should load recitations for a given khatmaId', () => {
    component.khatmaId = 1;
    component.ngOnInit();
  
    expect(recitationsService.getRecitations).toHaveBeenCalledWith({ limit: 30, params: [{ khatmaId: 1 }] });
    expect(component.recitations).toEqual(recitationData);
  
    // Subscribe to loaded$ and assert its value
    component.loaded$.pipe(take(1)).subscribe((loaded) => {
      expect(loaded).toBe(false);
    });
  });

  // it('should navigate to a recitation details page when recitation is clicked', () => {
  //   const router = TestBed.inject(Router) as jasmine.SpyObj<Router>;

  
  //   component.onRecitationClick(recitation);

  //   expect(router.navigate).toHaveBeenCalledWith(['/recitation-details', recitation.id]);
  // });
});


// ng test --include=src/app/recitations/recitations-list/recitations-list.component.spec.ts
