// import { Component, OnInit } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { LibraryService } from '../../services/library/library.service';
import { Observable } from 'rxjs/internal/Observable';
import { checkFormValidaty } from '../../common/form-validaty';
import { LibraryLanguageService } from '../../services/library/library-language.service';
import { LibraryCategoryService } from '../../services/library/library-category.service';
import { LibraryLanguageModel } from '../../models/library-language.model';
import { LibraryCategoryModel } from '../../models/library-category.model';
import { of } from 'rxjs';
// import { LibraryService } from '../library.service';

@Component({
  selector: 'file-form',
  templateUrl: './file-form.component.html',
  styleUrl: './file-form.component.scss'
})
export class FileFormComponent implements OnInit {
  form!: FormGroup;
  languages$: Observable<LibraryLanguageModel[]> = of([]);
  categories$: Observable<LibraryCategoryModel[]> = of([]);

  isDisabled$: Observable<boolean> = of(false);
  loaded$: Observable<boolean> = of(true);
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
    private libraryLanguageService: LibraryLanguageService,
    private libraryCategoryService: LibraryCategoryService,
  ) { }


  ngOnInit(): void {
    if (this.fileId) {
      // this.setFile();
      // this.pageTitle = "Edit File";
    }

    this.initForm();

    this.categories$.pipe((data) => {
      console.log('categories$ data ', data);
      return data;
    });
    this.languages$ = this.libraryLanguageService.getLanguages();
    this.categories$ = this.libraryCategoryService.getCategories();

  }


  initForm() {
    this.form = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(80)]],
      description: [''],
      language: ['', Validators.required],
      categories: [[], Validators.required],
      file: [null, Validators.required]
    });
    this.isDisabled$ = checkFormValidaty(this.form, this.loaded$);
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
        console.log(key, value);
        // if (key === 'categories') {
        //   value.forEach((v: any) => formData.append('categories[]', v));
        // } else {

        //   formData.append(key, value);
        // }
      });

      // this.libraryService.createFileEntry(formData).subscribe({
      //   next: (response) => console.log('File entry created successfully', response),
      //   error: (error) => console.error('Error creating file entry', error)
      // });
    }
  }

  copy() { }

  setFile(eve: any) {
    this.fileCtrl.setValue(eve);
  }

}
