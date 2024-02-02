import { ComponentFixture, TestBed } from '@angular/core/testing';
import { KawtharunaAppBarComponent } from './kawtharuna-app-bar.component';
import { ItunesService } from '../../../services/itunes/itunes.service';
import { of } from 'rxjs';
import { MatToolbarModule } from '@angular/material/toolbar';
import { HttpClientTestingModule } from '@angular/common/http/testing';

describe('KawtharunaAppBarComponent', () => {
  let component: KawtharunaAppBarComponent;
  let fixture: ComponentFixture<KawtharunaAppBarComponent>;
  let itunesServiceMock: any;


  beforeEach(async () => {
    // Mock ItunesService
    itunesServiceMock = {
      search: jasmine.createSpy('search').and.returnValue(of([]))
    };

    await TestBed.configureTestingModule({
      declarations: [KawtharunaAppBarComponent],
      providers: [
        { provide: ItunesService, useValue: itunesServiceMock }
      ],

      imports: [MatToolbarModule, HttpClientTestingModule]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(KawtharunaAppBarComponent);
    component = fixture.componentInstance;

    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should have default withSearch as true', () => {
    expect(component.withSearch).toBeTrue();
  });

  it('should set hideResult to true on onResultClick', () => {
    component.onResultClick();
    expect(component.hideResult).toBeTrue();
  });

  it('should call search method with expected parameter', () => {
    const testParam = 'test';
    component.search(testParam);
    expect(itunesServiceMock.search).toHaveBeenCalledWith(testParam);
  });

});


// ng test --include=src/app/shared/components/kawtharuna-app-bar/kawtharuna-app-bar.component.spec.ts