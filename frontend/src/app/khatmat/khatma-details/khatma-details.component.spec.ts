import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute, Router } from '@angular/router';
import { of } from 'rxjs';
import { KhatmaDetailsComponent } from './khatma-details.component';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { RecitationTypes } from '../../models/recitation.model';
import { KhatmaModel } from '../../models/khatma.model';
import { LocalizedModel } from '../../models/localized.model';
import { ReciterModel } from '../../models/reciter.model';
import { RecitationsListComponent } from '../../recitations/recitations-list/recitations-list.component';
import { RecitationsService } from '../../services/recitations/recitations.service';
import { PlayerService } from '../../services/player/player.service';
import { ItunesService } from '../../services/itunes/itunes.service';
import { KawtharunaAppBarComponent } from '../../shared/kawtharuna-app-bar/kawtharuna-app-bar.component';
import { MatToolbarModule } from '@angular/material/toolbar';

describe('KhatmaDetailsComponent', () => {
  let component: KhatmaDetailsComponent;
  let fixture: ComponentFixture<KhatmaDetailsComponent>;
  let khatmaService: jasmine.SpyObj<KhatmaService>;
  let activatedRoute: any;
  let router: any;
  let itunesServiceMock: ItunesService;


  // Sample localized name
  const localizedName = new LocalizedModel();
  localizedName.ar = 'ختمة 1';
  localizedName.en = 'Khatma 1';


  // Sample reciter data
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
  // Creating a sample KhatmaModel instance
  const dummyKhatma: KhatmaModel = new KhatmaModel();
  dummyKhatma.id = 1;
  dummyKhatma.name = localizedName;
  dummyKhatma.recitationType = 2;
  dummyKhatma.totalDownloads = 100;
  dummyKhatma.totalPlays = 50;
  dummyKhatma.reciter = dummyReciter1;

  beforeEach(() => {
    khatmaService = jasmine.createSpyObj('KhatmaService', ['getKhatma']);
    activatedRoute = {
      snapshot: {
        paramMap: {
          get: (param: string) => {
            if (param === 'khatmaId') {
              return '123'; // Replace with the desired khatmaId value for testing
            }
            return null;
          },
        },
        queryParamMap: {
          get: (param: string) => {
            if (param === 'value') {
              return 'someValue'; // Replace with the desired query parameter value for testing
            }
            return null;
          },
        },
      },
    };
    router = {
      navigate: jasmine.createSpy('navigate'),
    };
    const recitationsServiceSpy = jasmine.createSpyObj('RecitationsService', ['getRecitations']);
    const playerServiceSpy = jasmine.createSpyObj('PlayerService', ['playRecitation']);

    TestBed.configureTestingModule({
      imports: [MatToolbarModule],
      declarations: [KhatmaDetailsComponent, RecitationsListComponent, KawtharunaAppBarComponent],
      providers: [
        { provide: KhatmaService, useValue: khatmaService },
        { provide: ActivatedRoute, useValue: activatedRoute },
        { provide: Router, useValue: router },

        { provide: RecitationsService, useValue: recitationsServiceSpy },


        { provide: PlayerService, useValue: playerServiceSpy },
        { provide: ItunesService, useValue: itunesServiceMock }
      ],
    });

    fixture = TestBed.createComponent(KhatmaDetailsComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should fetch Khatma details and handle response', () => {
    khatmaService.getKhatma.and.returnValue(of(dummyKhatma));
    component.ngOnInit();
    expect(khatmaService.getKhatma).toHaveBeenCalledWith(123);

  });

});

// ng test --include=src/app/khatmat/khatma-details/khatma-details.component.spec.ts