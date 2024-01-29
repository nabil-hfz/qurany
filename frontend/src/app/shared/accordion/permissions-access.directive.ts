import { Directive, ElementRef, Input, OnDestroy, OnInit } from "@angular/core";
import { Store } from "@ngxs/store";
import { Subscription } from "rxjs";
import { map } from "rxjs/operators";
import { RoleModel } from "../../models/role.model";

@Directive({
  selector: "[permissionsAccess]",
})
export class PermissionsAccessDirective implements OnInit, OnDestroy {
  @Input() permission?: string | undefined;
  @Input() displayType: string = "block";

  sub = new Subscription();

  constructor(private elementRef: ElementRef, private store: Store) {}

  ngOnInit() {
    if (!this.permission) return;
    this.clear();

    this.sub.add(
      this.checkAccess().subscribe((hasAccess) => {
        this.elementRef.nativeElement.style.display = hasAccess
          ? this.displayType
          : "none";
      })
    );
  }

  clear() {
    this.elementRef.nativeElement.style.display = "none";
  }

  checkAccess() {
    return this.store
      .select<RoleModel[]>((state) => state?.auth?.roles)
      .pipe(
        map((roles) => {
          let userPermissions: string[] = [];

          if (roles && !roles.length) return false;

          roles?.forEach((role: RoleModel) => {
            if (role?.permissions)
              userPermissions.push(...role?.permissions?.map((p) => p?.key));
          });

          if (this.permission && userPermissions.includes(this.permission)) return true;
          return false;
        })
      );
  }
  ngOnDestroy(): void {
    this.sub.unsubscribe();
  }
}
