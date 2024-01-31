import { map, startWith } from "rxjs/operators";
import { combineLatest, Observable } from "rxjs";
import { FormGroup } from "@angular/forms";

/**
 * Checks the validity of a form and combines it with an Observable representing loading status.
 *
 * @param {FormGroup} form - The Angular FormGroup to check for validity.
 * @param {Observable<boolean>} loaded$ - An Observable representing the loading status.
 * @returns {Observable<boolean>} - An Observable that emits `true` when the form is invalid or not loaded, otherwise `false`.
 */
export function checkFormValidaty(
  form: FormGroup,
  loaded$: Observable<boolean>
) {
  // Create an Observable that tracks the form's status changes
  const formStatus$ = form.statusChanges.pipe(
    startWith(form.status),
    map((status) => status === "INVALID")
  );

  // Combine the form status and loading status Observables
  return combineLatest([formStatus$, loaded$]).pipe(
    map(([isInvalid, isLoaded]) => isInvalid || !isLoaded)
  );
}

/**
 * Converts seconds to a JavaScript Date object.
 *
 * @param {number | undefined | null} secs - The number of seconds to convert.
 * @returns {Date | null} - The Date object representing the converted time or null if `secs` is null or negative.
 */
export function fromSecondsToDateTime(secs?: number): Date | null {
  if (secs == null || secs < 0) {
    return null;
  }
  const inMilliseconds = secs * 1000;
  return new Date(inMilliseconds);
}
