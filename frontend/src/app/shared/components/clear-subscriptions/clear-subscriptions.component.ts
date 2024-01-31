import { Component, OnDestroy } from "@angular/core";
import { Subject } from "rxjs";

@Component({
  selector: "app-clear-subscriptions",
  template: "",
})
export class ClearSubscriptionsComponent implements OnDestroy {
  destroy$ = new Subject();

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }
}
