import { Injectable } from "@angular/core";
import {
    ActivatedRouteSnapshot,
    CanActivate,
    CanLoad,
    Route,
    Router,
    UrlSegment,
} from "@angular/router";
import { Observable } from "rxjs";
import { map, take } from "rxjs/operators";
import { AccountService } from "../../services/account/account.service";
import { MatDialog } from "@angular/material/dialog";
import { LoginComponent } from "../../login/login.component";

@Injectable({
    providedIn: "root",
})
export class AuthGuard implements CanActivate, CanLoad {
    constructor(
        public dialog: MatDialog,
        private accountService: AccountService,
        private router: Router
    ) { }

    canActivate(route: ActivatedRouteSnapshot): boolean {
        return this.isLoggedIn(route.url);
    }

    canLoad(route: Route, segments: UrlSegment[]): boolean {
        return this.isLoggedIn(segments);
    }

    isLoggedIn(url: UrlSegment[]): boolean {
        const isLoggedIn = this.accountService.isLoggedIn();
        if (isLoggedIn)
            return true;
        this.router.navigate(["/khatma"], {
            queryParams: { returnUrl: url },
        });
        this.dialog.open(LoginComponent, {
            width: '30%',
        });

        return false;

    }
}
