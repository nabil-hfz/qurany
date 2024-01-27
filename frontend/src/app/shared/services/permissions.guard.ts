// import { Injectable } from "@angular/core";
// import { ActivatedRouteSnapshot, CanActivate, Router } from "@angular/router";
// import { Store } from "@ngxs/store";
// import { Observable } from "rxjs";
// import { map, take } from "rxjs/operators";
// import { RoleModel } from "src/app/models/role.model";
// import { Auth } from "src/app/store";
// @Injectable({
//   providedIn: "root",
// })
// export class PermissionsGuard implements CanActivate {
//   constructor(private router: Router, private store: Store) {
//     this.store.dispatch(new Auth.InitRoles());
//   }

//   canActivate(route: ActivatedRouteSnapshot): Observable<boolean> {
//     return this.canAccess(route);
//   }

//   canAccess(route: ActivatedRouteSnapshot) {
//     return this.store
//       .select<RoleModel[]>((state) => state.auth.roles)
//       .pipe(
//         take(1),
//         map((roles) => this.hasPermissions(route, roles))
//       );
//   }

//   hasPermissions(route: ActivatedRouteSnapshot, roles: RoleModel[]) {
//     let userPermissions: string[] = [];
//     if (!roles || roles.length === 0) return false;
    
//     roles?.forEach((role: RoleModel) => {
//       if (role?.permissions)
//         userPermissions.push(...role?.permissions?.map((p) => p?.key));
//     });

//     if (userPermissions.includes(route?.data?.permission)) return true;

//     alert("you dont have permissions to access this page");
//     this.router.navigate(["/"]);
//     return false;
//   }
// }
