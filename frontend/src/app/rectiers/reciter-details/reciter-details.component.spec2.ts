import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReciterDetailsComponent } from './reciter-details.component';

describe('ReciterDetailsComponent', () => {
  let component: ReciterDetailsComponent;
  let fixture: ComponentFixture<ReciterDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReciterDetailsComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ReciterDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
