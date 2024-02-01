import { ComponentFixture, TestBed } from '@angular/core/testing';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ConfirmDialogComponent } from './confirm-dialog.component';

describe('ConfirmDialogComponent', () => {
  let component: ConfirmDialogComponent;
  let fixture: ComponentFixture<ConfirmDialogComponent>;
  let dialogRef: MatDialogRef<ConfirmDialogComponent>;
  let closeSpy: any;
  beforeEach(() => {
    closeSpy = jasmine.createSpy('close');
    TestBed.configureTestingModule({
      declarations: [ConfirmDialogComponent],
      providers: [
        {
          provide: MatDialogRef, useValue: { close: closeSpy }
        },
        {
          provide: MAT_DIALOG_DATA,
          useValue: { message: 'Test Message', hideDlelteBtn: false },
        },
      ],
    });
    fixture = TestBed.createComponent(ConfirmDialogComponent);
    component = fixture.componentInstance;
    dialogRef = TestBed.inject(MatDialogRef);
  });

  it('should create the component', () => {
    expect(component).toBeTruthy();
  });

  it('should close the dialog with confirmed: true when confirm() is called', () => {
    component.confirm();
    expect(closeSpy).toHaveBeenCalledWith({ confirmed: true });
  });

  it('should close the dialog with confirmed: false when close() is called', () => {

    component.close();
    expect(closeSpy).toHaveBeenCalledWith({ confirmed: false });
  });

  it('should display the message in the dialog content', () => {
    fixture.detectChanges(); // Trigger change detection
    const dialogContentElement = fixture.nativeElement.querySelector('.text-center h4');
    expect(dialogContentElement.textContent).toContain('Test Message');
  });

  it('should not display the Confirm button when hideDlelteBtn is truthy', () => {
    component.data.hideDlelteBtn = true;
    fixture.detectChanges(); // Trigger change detection
    const confirmButton = fixture.nativeElement.querySelector('.mat-flat-button[color="warn"]');
    expect(confirmButton).toBeFalsy();
  });

  it('should display the Confirm button when hideDlelteBtn is falsy', () => {
    fixture.detectChanges(); // Trigger change detection
    const confirmButton = fixture.nativeElement.querySelector('#warn-id');
    expect(confirmButton).toBeTruthy();
  });
});

// ng test --include=src/app/shared/components/confirm-dialog/confirm-dialog.component.spec.ts