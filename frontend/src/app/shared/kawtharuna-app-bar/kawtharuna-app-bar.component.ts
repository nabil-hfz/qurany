import { AfterViewInit, Component, ElementRef, Input, OnInit, ViewChild } from '@angular/core';
import { ItunesService } from '../../services/itunes/itunes.service';
// import { fromEvent, debounceTime } from 'rxjs';

@Component({
  selector: 'search-bar',
  templateUrl: './kawtharuna-app-bar.component.html',
  styleUrl: './kawtharuna-app-bar.component.scss'
})
export class KawtharunaAppBarComponent implements OnInit, AfterViewInit {


  @Input('withSearch')
  withSearch: boolean = true;

  hideResult: boolean = false;
  
  @ViewChild('searchBox') searchInput: ElementRef | undefined;
  searchResults: Array<any> = [];

  constructor(private ituneService: ItunesService) { }

  ngOnInit() { }

  ngAfterViewInit() {
    // if (this.searchInput && this.searchInput?.nativeElement) {
    //   let buttonStream$ = fromEvent(this.searchInput?.nativeElement, 'keyup')
    //     .pipe(debounceTime(1000))
    //     .subscribe(() => {
    //       this.search(this.searchInput?.nativeElement.value);
    //     });
    // }
  }

  onResultClick() {
    this.hideResult = true;
    // if (this.searchInput != null)
    //   this.searchInput!.nativeElement.value = '';
  }


  search(param: any) {
    // this.ituneService.search(param).subscribe(
    //   (data: any) => {
    //     // console.log(data['results']);
    //     this.hideResult = false;
    //     this.searchResults = data['results'];
    //   },
    //   err => console.log(err)
    // );
  }
}
