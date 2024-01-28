import { Component, OnDestroy } from "@angular/core";
import { Router } from "@angular/router";
import { Select, Store } from "@ngxs/store";
import { Observable, Subscription } from "rxjs";
import { SystemUser } from "src/app/models/user-system.model";
import { ROUTES } from "src/app/shared/consts/routes";
import { Auth, AuthSelector } from "src/app/store";

@Component({
  selector: "app-header",
  templateUrl: "./header.component.html",
  styleUrls: [],
})
export class AppHeaderComponent implements OnDestroy {
  @Select(AuthSelector.user) user$!: Observable<SystemUser>;
  sub = new Subscription();

  defaultMedia = "assets/images/users/thumb-2.png";

  constructor(private store: Store, private router: Router) {
    }

  logout() {
    this.sub.add(
      this.store.dispatch(new Auth.LogoutAction()).subscribe((state) => {
        if (state?.auth?.isLoggedIn) return;
        this.router.navigate(["./auth", ROUTES.LOGIN]);
      })
    );
  }

  ngOnDestroy(): void {
    this.sub.unsubscribe();
  }
}
