import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KawtharunaAppBarComponent } from './kawtharuna-app-bar.component';

describe('KawtharunaAppBarComponent', () => {
  let component: KawtharunaAppBarComponent;
  let fixture: ComponentFixture<KawtharunaAppBarComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [KawtharunaAppBarComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(KawtharunaAppBarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
