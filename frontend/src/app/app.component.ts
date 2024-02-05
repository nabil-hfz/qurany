// import { Component, OnInit } from '@angular/core';
// import { ItunesService } from './services/itunes/itunes.service';
// import { Router } from '@angular/router';

// @Component({
//   selector: 'app-root',
//   templateUrl: './app.component.html',
//   styleUrl: './app.component.scss'
// })
// export class AppComponent implements OnInit {
//   title = 'kawtharuna';
//   public isExpanded = true;

//   constructor(private router: Router) {
//     this.router.events.subscribe(event => {
//       console.log('event is AppComponent ' + event);
//     });
//   }


//   public toggleMenu() {
//     this.isExpanded = !this.isExpanded;
//   }


//   ngOnInit() { }
// }



import { MediaMatcher } from "@angular/cdk/layout";
import {
  ChangeDetectorRef,
  Component,
  OnDestroy,
  AfterViewInit,
  OnInit,
} from "@angular/core";
import { Actions, ofActionErrored, Store } from "@ngxs/store";
import { ToastrService } from "ngx-toastr";
import { Subscription } from "rxjs";
import { MenuItems } from "./shared/menu-items/menu-items";
import { Router } from "@angular/router";
// import { MenuItems } from "../../../menu-items/menu-items";
// import { Auth } from "src/app/store";

/** @title Responsive sidenav */
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
  // selector: "app-full-layout",
  // templateUrl: "full.component.html",
  // styleUrls: [],
})
export class AppComponent implements OnDestroy, AfterViewInit, OnInit {
  mobileQuery: MediaQueryList;
  private _mobileQueryListener: () => void;
  sub = new Subscription();
  constructor(
    changeDetectorRef: ChangeDetectorRef,
    media: MediaMatcher,
    public menuItems: MenuItems,
    private store: Store,
    private actions$: Actions,
    private toastrService: ToastrService,
    private router: Router) {
    this.router.events.subscribe(event => {
      console.log('event is AppComponent ' + event);
    });
    this.mobileQuery = media.matchMedia("(min-width: 768px)");
    this._mobileQueryListener = () => changeDetectorRef.detectChanges();
    this.mobileQuery.addListener(this._mobileQueryListener);
  }

  ngOnInit(): void {
    // this.store.dispatch([new Auth.GetMyProfile(),new Auth.InitRoles()]);

    // this.sub.add(
    //   this.actions$.pipe(ofActionErrored(Auth.GetMyProfile)).subscribe(() => {
    //     this.toastrService.error("Something Failed");
    //   })
    // );
  }
  ngOnDestroy(): void {
    this.mobileQuery.removeListener(this._mobileQueryListener);
    this.sub.unsubscribe();
  }

  ngAfterViewInit() { }


  title = 'kawtharuna';
  public isExpanded = true;



  public toggleMenu() {
    this.isExpanded = !this.isExpanded;
  }
}
