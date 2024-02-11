import { AfterViewInit, Component, ElementRef, Input, OnInit, ViewChild } from '@angular/core';
import { ItunesService } from '../../../services/itunes/itunes.service';
import { LoginComponent } from '../../../login/login.component';
import { MatDialog } from '@angular/material/dialog';
import { AccountService } from '../../../services/account/account.service';
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

  constructor(
    public dialog: MatDialog,
    private ituneService: ItunesService,
    private accountService: AccountService,) { }

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


  search(param: any): any {
    this.ituneService.search(param);
    // .subscribe(
    //   (data: any) => {
    //     // console.log(data['results']);
    //     this.hideResult = false;
    //     this.searchResults = data['results'];
    //   },
    //   err => console.log(err)
    // );
    return param;
  }

  onLogin() {
    console.log('onLogin');
    this.dialog.open(LoginComponent, {
      width: '30%',
    });
  }

  onLogout() {
    console.log('onLogout');
    this.accountService.logout();
  }

  get isLoggedIn(): boolean {
    return this.accountService.isLoggedIn();
  }
}
