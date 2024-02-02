import { ComponentFixture, TestBed } from '@angular/core/testing';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CopySettingComponent } from './copy-setting.component';
import { NO_ERRORS_SCHEMA } from '@angular/core';

describe('CopySettingComponent', () => {
  let component: CopySettingComponent;
  let fixture: ComponentFixture<CopySettingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [CopySettingComponent],
      providers: [
        { provide: MatDialogRef, useValue: {} },
        { provide: MAT_DIALOG_DATA, useValue: { settings: [{ label: 'Test Label', key: 'test_key', checked: true }] } }
      ],
      schemas: [NO_ERRORS_SCHEMA]
    })
      .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CopySettingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
  it('should initialize settings with data provided', () => {
    expect(component.settings).toEqual([{ label: 'Test Label', key: 'test_key', checked: true }]);
  });

  it('should close the dialog with the correct list data on save', () => {
    const dialogRefSpy = spyOn(TestBed.get(MatDialogRef), 'close');
    component.list = [{ key: 'test_key', value: 'Test Value' }]; // Assuming this list is populated somehow in your component
    component.save();
    expect(dialogRefSpy).toHaveBeenCalledWith({ list: [{ key: 'test_key', value: 'Test Value' }] });
  });

});

// ng test --include=src/app/shared/components/copy-setting/copy-setting.component.spec.ts