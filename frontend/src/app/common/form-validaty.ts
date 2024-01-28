import { map, startWith } from "rxjs/operators";
import { combineLatest, Observable } from "rxjs";
import { FormGroup } from "@angular/forms";

export function checkFormValidaty(
  form: FormGroup,
  loaded$: Observable<boolean>
) {
  const formStatus$ = form.statusChanges.pipe(
    startWith(form.status),
    map((status) => status === "INVALID")
  );

  return combineLatest([formStatus$, loaded$]).pipe(
    map(([isInvalid, isLoaded]) => isInvalid || !isLoaded)
  );
}

export function  fromSecondsToDateTime(secs?:number):Date| null {
  if(secs == null)return null;
  var t = new Date(secs * 1000); // Epoch
  // t.setSeconds(secs * 1000);
  return t;
}
