import { LocalizedModel } from './../../models/localized.model';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { RecitersGridComponent } from './reciters-grid.component';
import { Router } from '@angular/router';
import { RecitersService } from '../../services/reciters/reciters.service';
import { of } from 'rxjs';
import { RecitationTypes } from '../../models/recitation.model';
import { ReciterModel } from '../../models/reciter.model';
import { MatToolbarModule } from '@angular/material/toolbar';

describe('RecitersGridComponent', () => {
  let component: RecitersGridComponent;
  let fixture: ComponentFixture<RecitersGridComponent>;
  let router: Router;
  let recitersService: RecitersService;
  let dummyReciter1: ReciterModel;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, MatToolbarModule],
      declarations: [RecitersGridComponent],
      providers: [RecitersService, Router],
    }).compileComponents();

    fixture = TestBed.createComponent(RecitersGridComponent);
    component = fixture.componentInstance;
    router = TestBed.inject(Router);
    recitersService = TestBed.inject(RecitersService);
    const localizedModel = new LocalizedModel();
    localizedModel.ar = 'الشيخ أحمد';
    localizedModel.en = 'Sheikh Ahmed';
    recitersService = TestBed.inject(RecitersService);
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
  });



  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should fetch reciters list and set items', fakeAsync(() => {

    const mockReciters: ReciterModel[] = [dummyReciter1];
    spyOn(recitersService, 'getRecitersList').and.returnValue(of({ items: mockReciters }));

    component.ngOnInit();
    tick(); // Wait for asynchronous operation to complete

    expect(component.items).toEqual(mockReciters);
    expect(component.isLoading).toBeFalse();
  }));

  it('should navigate to khatmat-grid when onCardPressed is called', () => {

    const routerSpy = spyOn(router, 'navigate');

    component.onCardPressed(dummyReciter1);

    console.log('onCardPressed', dummyReciter1.name.currentValue);
    expect(routerSpy).toHaveBeenCalledWith(['/khatmat-grid', dummyReciter1.id, 'الشيخ-أحمد']);
  });
});

// ng test --include=src/app/rectiers/reciters-grid/reciters-grid.component.spec.ts
