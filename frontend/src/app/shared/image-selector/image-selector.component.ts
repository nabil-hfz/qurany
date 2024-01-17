

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

  onFileSelected(event: Event): void {
    const file = (event.target as HTMLInputElement).files?.[0];
    console.log('2- onFileSelected file is ', file);
    if (file) {
      const reader = new FileReader();
      reader.onload = _ => {
        this.imageUrl = reader.result;
        console.log('3- onFileSelected file is ',     this.imageUrl);
        this.onChange(file);
      };
      reader.readAsDataURL(file);
    }
  }

  writeValue(obj: any): void {
    this.imageUrl = obj;
  }

  registerOnChange(fn: any): void {
    this.onChange = fn;
  }

  registerOnTouched(fn: any): void {
    this.onTouched = fn;
  }
}

