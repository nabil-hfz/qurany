import { Component } from "@angular/core";
import { Actions, ofActionErrored, ofActionSuccessful } from "@ngxs/store";
import { ToastrService } from "ngx-toastr";
import { catchError, takeUntil } from "rxjs/operators";
import { ClearSubscriptionsComponent } from "../clear-subscriptions/clear-subscriptions.component";

@Component({
  selector: "app-notification",
  template: "",
})
export class NotificationComponent extends ClearSubscriptionsComponent {
  errorActions: any[] = [];
  successActions: any[] = [];
  defaultErrorMsg: string = "Something failed";
  defaultSuccessMsg: string = "Operation completed successfully";

  constructor(public actions$: Actions, public toastrService: ToastrService) {
    super();
  }

  excute(): void {
    this.handleErrorsActions();
    this.handleSuccessActions();
  }

  handleErrorsActions() {
    this.actions$
      .pipe(
        ofActionErrored(...this.errorActions),
        takeUntil(this.destroy$),
        catchError((err) => {
          throw err;
        })
      )
      .subscribe((res) => {
        
        this.toastrService.error(this.defaultErrorMsg);
      });
  }

  handleSuccessActions() {
    this.actions$
      .pipe(
        ofActionSuccessful(...this.successActions),
        takeUntil(this.destroy$)
      )
      .subscribe((res) => {
        this.toastrService.success(this.defaultSuccessMsg);
      });
  }
}
