import { ComponentFixture, TestBed } from '@angular/core/testing';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { AskDialogComponent } from './ask-dialog.component';

describe('AskDialogComponent', () => {
  let component: AskDialogComponent;
  let fixture: ComponentFixture<AskDialogComponent>;
  let dialogRef: MatDialogRef<AskDialogComponent>;

  let dialogRefMock: any;


  beforeEach(() => {
    // Create a mock MatDialogRef
    dialogRefMock = {
      close: jasmine.createSpy('close'),
    };
    TestBed.configureTestingModule({
      declarations: [AskDialogComponent],
      providers: [
        { provide: MatDialogRef, useValue: dialogRefMock },
        { provide: MAT_DIALOG_DATA, useValue: { message: 'Test Message' } },
      ],
    });
    fixture = TestBed.createComponent(AskDialogComponent);
    component = fixture.componentInstance;
    dialogRef = TestBed.inject(MatDialogRef);
  });

  it('should create the component', () => {
    expect(component).toBeTruthy();
  });

  it('should close the dialog with confirmed: true when confirm() is called', () => {
    component.confirm();
    expect(dialogRefMock.close).toHaveBeenCalledWith({ confirmed: true });
  });

  it('should close the dialog with confirmed: false when close() is called', () => {
    component.close();
    expect(dialogRefMock.close).toHaveBeenCalledWith({ confirmed: false });
  });

  it('should display the message in the dialog content', () => {
    fixture.detectChanges(); // Trigger change detection
    const dialogContentElement = fixture.nativeElement.querySelector('.text-center h4');
    expect(dialogContentElement.textContent).toContain('Test Message');
  });
});

// ng test --include=src/app/shared/components/ask-dialog/ask-dialog.component.spec.ts
