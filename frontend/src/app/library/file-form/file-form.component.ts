// import { Component, OnInit } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { LibraryService } from '../../services/library/library.service';
import { Observable } from 'rxjs/internal/Observable';
// import { LibraryService } from '../library.service';

@Component({
  selector: 'file-form',
  templateUrl: './file-form.component.html',
  styleUrl: './file-form.component.scss'
})
export class FileFormComponent implements OnInit {
  form!: FormGroup;
  languages$ = this.libraryService.getLanguages();
  categories$ = this.libraryService.getCategories();
  isDisabled$!: Observable<boolean>;
  loaded$!: Observable<boolean>;
  pageTitle = "Add File";
  fileId = -1;

  get nameCtrl() {
    return this.form.get("name") as FormControl;
  }

  get descriptionCtrl() {
    return this.form.get("description") as FormControl;
  }

  get languageCtrl() {
    return this.form.get("language") as FormControl;
  }

  get categoriesCtrl() {
    return this.form.get("categories") as FormControl;
  }

  get fileCtrl() {
    return this.form.get("file") as FormControl;
  }


  constructor(
    private fb: FormBuilder,
    private libraryService: LibraryService,
  ) { }


  ngOnInit(): void {
    // if (this.fileId)
    {
      // this.setFile();
      this.pageTitle = "Edit File";
    }

    this.initForm();
    this.categories$.pipe((data) => {
      console.log('categories$ data ', data);
      return data;
    });
  }


  initForm() {
    this.form = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(80)]],
      description: [''],
      language: ['', Validators.required],
      categories: [[], Validators.required],
      file: [null, Validators.required]
    });


    // this.new FormGroup({
    //   name: new FormGroup({
    //     en: new FormControl(null, Validators.required),
    //     ar: new FormControl(""),
    //   }),
    //   description: new FormGroup({
    //     en: new FormControl(null, Validators.required),
    //     ar: new FormControl(""),
    //   }),
    //   status: new FormControl(null, Validators.required),
    //   category: new FormControl(null, Validators.required),
    //   skill: new FormControl(6),
    //   image: new FormControl(null),
    //   clubFees: new FormControl(null, [Validators.required, Validators.min(0)]),
    //   autoJoined: new FormControl(true, [Validators.required]),
    // });
  }
  onFileSelect(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      this.form.patchValue({ file: file });
    }
  }

  submit() {
    if (this.form.valid) {
      const formData = new FormData();
      Object.entries(this.form.value).forEach(([key, value]) => {
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

  copy() { }

}
