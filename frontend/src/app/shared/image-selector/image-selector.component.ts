import { Component, forwardRef } from '@angular/core';
import { NG_VALUE_ACCESSOR, ControlValueAccessor } from '@angular/forms';

@Component({
  selector: 'app-image-selector',
  templateUrl: './image-selector.component.html',
  styleUrls: ['./image-selector.component.scss'],
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => ImageSelectorComponent),
      multi: true
    }
  ]
})
export class ImageSelectorComponent implements ControlValueAccessor {
  imageUrl: string | ArrayBuffer | null = null;
  onChange!: (image: File) => void;
  onTouched!: () => void;

  // This method is called when a file is selected through an input element
  onFileSelected(event: Event): void {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = _ => {
        // Set the selected image URL for preview
        this.imageUrl = reader.result;
        // Notify the form control that the value has changed
        this.onChange(file);
      };
      reader.readAsDataURL(file);
    }
  }

  // Called when the form control is initialized with a value
  writeValue(obj: any): void {
    this.imageUrl = obj;
  }

  // Register a function to be called when the value changes
  registerOnChange(fn: any): void {
    this.onChange = fn;
  }

  // Register a function to be called when the control is touched
  registerOnTouched(fn: any): void {
    this.onTouched = fn;
  }
}
