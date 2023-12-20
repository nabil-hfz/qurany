import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KhatmaDetailsComponent } from './khatma-details.component';

describe('KhatmaDetailsComponent', () => {
  let component: KhatmaDetailsComponent;
  let fixture: ComponentFixture<KhatmaDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [KhatmaDetailsComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(KhatmaDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
