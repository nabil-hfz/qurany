import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KhatmatGridComponent } from './khatmat-grid.component';

describe('KhatmaGridComponent', () => {
  let component: KhatmatGridComponent;
  let fixture: ComponentFixture<KhatmatGridComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [KhatmatGridComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(KhatmatGridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
