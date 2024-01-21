import { ComponentFixture, TestBed } from '@angular/core/testing';
import { Observable, of } from 'rxjs';
import { LibraryGridComponent } from './library-grid.component';
import { LibraryService } from '../../services/library/library.service';
import { LocalizedModel } from '../../models/localized.model';
import { LibraryCategoryModel } from '../../models/library-category.model';
import { LibraryLanguageModel } from '../../models/library-language.model';
import { LibraryModel } from '../../models/library.model';
import { ItunesService } from '../../services/itunes/itunes.service';
import { KawtharunaAppBarComponent } from '../../shared/kawtharuna-app-bar/kawtharuna-app-bar.component';
import { MatToolbarModule } from '@angular/material/toolbar';

describe('LibraryGridComponent', () => {
  let component: LibraryGridComponent;
  let fixture: ComponentFixture<LibraryGridComponent>;
  let libraryService: jasmine.SpyObj<LibraryService>;
  let itunesServiceMock: ItunesService;

  const dummyLibrary: LibraryModel = {
    id: 1,
    name: 'Sample Library Resource',
    language: {
      id: 1,
      name: 'English',
    } as LibraryLanguageModel,
    categories: [
      {
        id: 1,
        name: {
          ar: 'تصنيف العينة',
          en: 'Sample Category',
        } as LocalizedModel,
      } as LibraryCategoryModel,
    ],
    file: 'sample-resource.pdf',
    thumbnail: 'sample-thumbnail.jpg',
    totalViews: 1000,
    totalDownloads: 500,
    description: 'This is a sample library resource for testing purposes.',
    createdAt: new Date(),
  };

  const dummyLibraryData = [dummyLibrary];

  beforeEach(() => {
    libraryService = jasmine.createSpyObj('LibraryService', ['getLibraryFiles']);

    TestBed.configureTestingModule({
      declarations: [LibraryGridComponent, KawtharunaAppBarComponent],
      providers: [
        { provide: LibraryService, useValue: libraryService },
        { provide: ItunesService, useValue: itunesServiceMock }

      ],
      imports: [MatToolbarModule]

    });

    fixture = TestBed.createComponent(LibraryGridComponent);
    component = fixture.componentInstance;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should fetch library files and handle response', () => {
    libraryService.getLibraryFiles.and.returnValue(of(dummyLibraryData));

    component.ngOnInit();

    expect(libraryService.getLibraryFiles).toHaveBeenCalled();

  });


});
