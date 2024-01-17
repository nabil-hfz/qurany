import { ComponentFixture, ComponentFixtureAutoDetect, TestBed, async, fakeAsync, tick } from '@angular/core/testing';
import { ImageSelectorComponent } from './image-selector.component';
import { By } from '@angular/platform-browser';

import { FormsModule } from '@angular/forms';


describe('ImageSelectorComponent', () => {
  let component: ImageSelectorComponent;
  let fixture: ComponentFixture<ImageSelectorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ImageSelectorComponent],
      imports: [FormsModule],
      providers: [{ provide: ComponentFixtureAutoDetect, useValue: true }],
    }).compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ImageSelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });


  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should set imageUrl when writeValue is called', () => {
    const testUrl = 'data:image/png;base64,TestBase64String==';
    component.writeValue(testUrl);
    expect(component.imageUrl).toBe(testUrl);
  });

  it('should register onChange and onTouched functions', () => {
    const testOnChange = (image: File) => console.log(image);
    const testOnTouched = () => console.log('Touched');

    component.registerOnChange(testOnChange);
    expect(component['onChange']).toBe(testOnChange);

    component.registerOnTouched(testOnTouched);
    expect(component['onTouched']).toBe(testOnTouched);
  });


  it('should display "Select Image" button when no image is selected', () => {
    const selectImageBtn = fixture.debugElement.query(By.css('.btn-primary'));
    expect(selectImageBtn.nativeElement.textContent).toContain('Select Image');
  });

  it('should display "Edit Image" button when an image is selected', () => {
    component.writeValue('data:image/jpeg;base64,...'); // Simulate an image selection
    fixture.detectChanges();

    const editImageBtn = fixture.debugElement.query(By.css('.btn-primary'));
    expect(editImageBtn.nativeElement.textContent).toContain('Edit Image');
  });

  it('should trigger onFileSelected method when the file input changes', () => {
    spyOn(component, 'onFileSelected');
    const fileInput = fixture.debugElement.query(By.css('input[type="file"]'));
    const event = new Event('change');

    fileInput.triggerEventHandler('change', event);

    expect(component.onFileSelected).toHaveBeenCalled();
  });

});

// ng test --include=src/app/shared/image-selector/image-selector.component.spec.ts
