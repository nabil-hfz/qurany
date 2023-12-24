import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecitationCardComponent } from './recitation-card.component';

describe('RecitationCardComponent', () => {
  let component: RecitationCardComponent;
  let fixture: ComponentFixture<RecitationCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RecitationCardComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(RecitationCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
