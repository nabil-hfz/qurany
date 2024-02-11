import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute, Router } from '@angular/router';
import { KhatmatGridComponent } from './khatmat-grid.component';
import { KhatmaService } from '../../services/khatma/khatma.service';
import { of } from 'rxjs';
import { KhatmaModel } from '../../models/khatma.model';
import { ReciterModel } from '../../models/reciter.model';
import { LocalizedModel } from '../../models/localized.model';
import { RecitationTypes } from '../../models/recitation.model';
import { KawtharunaAppBarComponent } from '../../shared/components/kawtharuna-app-bar/kawtharuna-app-bar.component';
import { ItunesService } from '../../services/itunes/itunes.service';
import { MatToolbarModule } from '@angular/material/toolbar';

describe('KhatmatGridComponent', () => {
  let component: KhatmatGridComponent;
  let fixture: ComponentFixture<KhatmatGridComponent>;
  let khatmaService: jasmine.SpyObj<KhatmaService>;
  let router: jasmine.SpyObj<Router>;
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
    const khatmaServiceSpy = jasmine.createSpyObj('KhatmaService', ['getKhatmat']);
    const routerSpy = jasmine.createSpyObj('Router', ['navigate']);

    TestBed.configureTestingModule({
      declarations: [KhatmatGridComponent, KawtharunaAppBarComponent],
      providers: [
        { provide: KhatmaService, useValue: khatmaServiceSpy },
        { provide: Router, useValue: routerSpy },
        {
          provide: ActivatedRoute,
          useValue: {
            queryParams: of({}),
          },
        },
        { provide: ItunesService, useValue: itunesServiceMock }
      ],
      imports: [MatToolbarModule]
    });

    fixture = TestBed.createComponent(KhatmatGridComponent);
    component = fixture.componentInstance;
    khatmaService = TestBed.inject(KhatmaService) as jasmine.SpyObj<KhatmaService>;
    router = TestBed.inject(Router) as jasmine.SpyObj<Router>;
  });

  it('should create the component', () => {
    expect(component).toBeTruthy();
  });

  it('should load khatmat on ngOnInit', () => {
    const dummyKhatmaData: KhatmaModel[] = [dummyKhatma];

    khatmaService.getKhatmat.and.returnValue(of(dummyKhatmaData));

    component.ngOnInit();

    expect(khatmaService.getKhatmat).toHaveBeenCalled();

    // Update the expectations based on your actual implementation
    // Ensure that loading$ and values$ observables are properly set
    component.loading$.subscribe((loading) => {
      expect(loading).toBe(false);
    });

    component.values$?.subscribe((values) => {
      expect(values).toEqual(dummyKhatmaData);
    });
  });


  it('should navigate to khatma details on card press', () => {


    component.onCardPressed(dummyKhatma);

    const expectedUrl = ['khatma-details', dummyKhatma.id, 'ختمة-1'];
    expect(router.navigate).toHaveBeenCalledWith(expectedUrl, { queryParams: dummyKhatma });
  });

  // it('should navigate to form on navigateToForm', () => {
  //   component.navigateToForm();


  // const expectedUrl = ['/portfolios/add'];
  // expect(router.navigate).toHaveBeenCalledWith(expectedUrl);
  // });
});
// ng test --include=src/app/khatmat/khatmat-grid/khatmat-grid.component.spec.ts