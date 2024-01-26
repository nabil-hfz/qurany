// import { Component, OnInit } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { LibraryService } from '../../services/library/library.service';
// import { LibraryService } from '../library.service';

@Component({
  selector: 'file-form',
  templateUrl: './file-form.component.html',
  styleUrl: './file-form.component.css'
})
export class FileFormComponent implements OnInit {
  fileForm!: FormGroup;
  languages$ = this.libraryService.getLanguages();
  categories$ = this.libraryService.getCategories();

  constructor(
    private fb: FormBuilder,
    private libraryService: LibraryService,
  ) { }

  ngOnInit(): void {
    this.fileForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(80)]],
      description: [''],
      language: ['', Validators.required],
      categories: [[], Validators.required],
      file: [null, Validators.required]
    });

    this.categories$.pipe((data) => {
      console.log('categories$ data ', data);
      return data;
    });
  }

  onFileSelect(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      this.fileForm.patchValue({ file: file });
    }
  }

  submit() {
    if (this.fileForm.valid) {
      const formData = new FormData();
      Object.entries(this.fileForm.value).forEach(([key, value]) => {
        if (key === 'categories') {
          // value.forEach((v: any) => formData.append('categories[]', v));
        } else {
          // formData.append(key, value);
        }
      });

      this.libraryService.createFileEntry(formData).subscribe({
        next: (response) => console.log('File entry created successfully', response),
        error: (error) => console.error('Error creating file entry', error)
      });
    }
  }
}
