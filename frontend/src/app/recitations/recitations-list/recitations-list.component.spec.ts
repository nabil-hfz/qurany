import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecitationsListComponent } from './recitations-list.component';

describe('RecitationsListComponent', () => {
  let component: RecitationsListComponent;
  let fixture: ComponentFixture<RecitationsListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RecitationsListComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(RecitationsListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
