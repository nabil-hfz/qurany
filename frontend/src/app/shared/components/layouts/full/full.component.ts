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
import { MenuItems } from "../../../menu-items/menu-items";
// import { Auth } from "src/app/store";

/** @title Responsive sidenav */
@Component({
  selector: "app-full-layout",
  templateUrl: "full.component.html",
  styleUrls: [],
})
export class FullComponent implements OnDestroy, AfterViewInit, OnInit {
  mobileQuery: MediaQueryList;
  private _mobileQueryListener: () => void;
  sub = new Subscription();
  constructor(
    changeDetectorRef: ChangeDetectorRef,
    media: MediaMatcher,
    public menuItems: MenuItems,
    private store: Store,
    private actions$: Actions,
    private toastrService: ToastrService
  ) {
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

  ngAfterViewInit() {}
}
