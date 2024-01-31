// import { Injectable } from "@angular/core";
// import { AngularFireAuth } from "@angular/fire/compat/auth";
// import {
//   ActivatedRouteSnapshot,
//   CanActivate,
//   CanLoad,
//   Route,
//   Router,
//   UrlSegment,
// } from "@angular/router";
// import { Observable } from "rxjs";
// import { map, take } from "rxjs/operators";

// @Injectable({
//   providedIn: "root",
// })
// export class AuthGuard implements CanActivate, CanLoad {
//   constructor(private authFire: AngularFireAuth, private router: Router) {}

//   canActivate(route: ActivatedRouteSnapshot): Observable<boolean> {
//     return this.isLoggedIn(route.url);
//   }

//   canLoad(route: Route, segments: UrlSegment[]): Observable<boolean> {
//     return this.isLoggedIn(segments);
//   }

//   isLoggedIn(url: UrlSegment[]) {
//     return this.authFire.user.pipe(
//       take(1),
//       map((res) => {
//         if (res?.uid) return true;

//         this.router.navigate(["/auth"], {
//           queryParams: { returnUrl: url },
//         });

//         return false;
//       })
//     );
//   }
// }
