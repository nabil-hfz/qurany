import { ComponentFixture, TestBed } from '@angular/core/testing';
import { NotificationComponent } from './notification.component';
import { ToastrService } from 'ngx-toastr';
import { Actions, NgxsModule, ofActionErrored, ofActionSuccessful } from '@ngxs/store';
import { Observable, Subject, of, throwError } from 'rxjs';
import { AppBadInputError } from '../../../common/bad-input';

describe('NotificationComponent', () => {
  let component: NotificationComponent;
  let fixture: ComponentFixture<NotificationComponent>;
  let toastrService: jasmine.SpyObj<ToastrService>;
  let actions$: Observable<any>;

  beforeEach(async () => {
    toastrService = jasmine.createSpyObj('ToastrService', ['success', 'error']);

    await TestBed.configureTestingModule({
      imports: [NgxsModule.forRoot([])],
      declarations: [NotificationComponent],
      providers: [
        { provide: ToastrService, useValue: toastrService },
        // Mocking Actions stream
        {
          provide: Actions,
          useValue: {
            pipe: () => of({})
          }
        }
      ]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NotificationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });


  it('should display a success toast when a success action occurs', (done) => {
    const actions$: Actions = TestBed.inject(Actions);
    spyOn(actions$, 'pipe').and.returnValue(of({})); // Simulate success action

    component.successActions = ["SomeSuccessAction"];
    component.excute();

    fixture.whenStable().then(() => {
      expect(toastrService.success).toHaveBeenCalledWith(component.defaultSuccessMsg);
      done();
    });
  });


});


// describe('NotificationComponent', () => {
//   let component: NotificationComponent;
//   let toastrService: jasmine.SpyObj<ToastrService>;
//   let actions$ = new Subject<any>();

//   beforeEach(async () => {
//     toastrService = jasmine.createSpyObj('ToastrService', ['success', 'error']);

//     await TestBed.configureTestingModule({
//       imports: [NgxsModule.forRoot([])],
//       declarations: [NotificationComponent],
//       providers: [
//         { provide: ToastrService, useValue: toastrService },
//         { provide: Actions, useValue: actions$ }
//       ]
//     }).compileComponents();

//     const fixture = TestBed.createComponent(NotificationComponent);
//     component = fixture.componentInstance;
//   });

//   it('should display an error toast when an error action occurs', () => {
//     // Setup error action to be emitted
//     component.errorActions = [AppBadInputError];
//     component.excute();

//     // Emit the error action
//     actions$.error(new AppBadInputError()); // Adjust this to match how your actions are structured

//     // Check if error toast was called
//     setTimeout(() => {
//       expect(toastrService.error).toHaveBeenCalledWith(component.defaultErrorMsg);
//     }, 0);
//   });
// });

// ng test --include=src/app/shared/components/notification/notification.component.spec.ts