import { FormControl, FormGroup, Validators } from "@angular/forms";
import { of } from "rxjs";
import { checkFormValidaty, fromSecondsToDateTime } from "./form-validaty";

describe("checkFormValidaty", () => {
  it("should return true when form is INVALID and loaded$ is true", () => {
    const form = new FormGroup({
      username: new FormControl('', Validators.required),
      email: new FormControl('invalid-email', Validators.email),
      password: new FormControl('short', Validators.minLength(6)),
    });
    const loaded$ = of(true);

    const result$ = checkFormValidaty(form, loaded$);

    result$.subscribe(result => {
      expect(result).toBe(true);
    });
  });

  it("should return false when form is VALID and loaded$ is true", () => {
    const form = new FormGroup({
      username: new FormControl('john_doe', Validators.required),
      email: new FormControl('john.doe@example.com', Validators.email),
      password: new FormControl('securePassword123', Validators.minLength(6)),
    });

    const loaded$ = of(true);

    const result$ = checkFormValidaty(form, loaded$);

    result$.subscribe(result => {
      expect(result).toBe(false);
    });
  });

  it("should return true when form is VALID and loaded$ is false", () => {
    const form = new FormGroup({
      username: new FormControl('john_doe', Validators.required),
      email: new FormControl('john.doe@example.com', Validators.email),
      password: new FormControl('securePassword123', Validators.minLength(6)),
    });

    const loaded$ = of(false);

    const result$ = checkFormValidaty(form, loaded$);

    result$.subscribe(result => {
      expect(result).toBe(true);
    });
  });

});


describe("fromSecondsToDateTime", () => {
  it("should return null when input is null", () => {
    const result = fromSecondsToDateTime(undefined);
    expect(result).toBe(null);
  });

  it("should return a valid Date object when input is a valid number of seconds", () => {
    const seconds = 1632044342; // Replace with a valid number of seconds
    const result = fromSecondsToDateTime(seconds);
    expect(result instanceof Date).toBe(true);
  });

  it("should handle negative input correctly", () => {
    const seconds = -100; // Replace with a negative number of seconds
    const result = fromSecondsToDateTime(seconds);
    expect(result).toBe(null); // Since negative seconds don't represent a valid date
  });


});

// ng test --include=src/app/common/form-validaty.spec.ts

