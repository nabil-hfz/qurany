import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecitersGridComponent } from './reciters-grid.component';

describe('RecitersGridComponent', () => {
  let component: RecitersGridComponent;
  let fixture: ComponentFixture<RecitersGridComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RecitersGridComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(RecitersGridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
