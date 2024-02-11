import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ClearSubscriptionsComponent } from './clear-subscriptions.component';
import { Subject } from 'rxjs';

describe('ClearSubscriptionsComponent', () => {
  let component: ClearSubscriptionsComponent;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ClearSubscriptionsComponent],
    });
    const fixture = TestBed.createComponent(ClearSubscriptionsComponent);
    component = fixture.componentInstance;
  });

  it('should create the component', () => {
    expect(component).toBeTruthy();
  });

  it('should complete the destroy$ Subject on ngOnDestroy', () => {
    const spyNext = spyOn(component.destroy$, 'next');
    const spyComplete = spyOn(component.destroy$, 'complete');

    component.ngOnDestroy();

    expect(spyNext).toHaveBeenCalledWith(null);
    expect(spyComplete).toHaveBeenCalled();
  });
});

// ng test --include=src/app/shared/components/clear-subscriptions/clear-subscriptions.component.spec.ts
