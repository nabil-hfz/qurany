import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ImageSelectorComponent } from './image-selector.component';
import { By } from '@angular/platform-browser';

describe('ImageSelectorComponent', () => {
  let component: ImageSelectorComponent;
  let fixture: ComponentFixture<ImageSelectorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ImageSelectorComponent ]
    })
    .compileComponents();
  });

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

});

// ng test --include=src/app/shared/image-selector/image-selector.component.spec.ts
