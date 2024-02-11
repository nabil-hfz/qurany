import { AppErrorHandler } from "./app-error-handler";
import { AppNotFoundError } from "./not-found-error";
import { AppBadError } from "./bad-error";

describe("AppErrorHandler", () => {
  let errorHandler: AppErrorHandler;

  beforeEach(() => {
    errorHandler = new AppErrorHandler();
  });

  it("should handle AppNotFoundError by displaying an alert", () => {
    const notFoundError = new AppNotFoundError();
    spyOn(window, "alert");

    errorHandler.handleError(notFoundError);

    expect(window.alert).toHaveBeenCalledWith(
      "This item has already been deleted or not found."
    );
  });

  it("should handle AppBadInputError by displaying an alert", () => {
    const badInputError = new AppBadError();
    spyOn(window, "alert");

    errorHandler.handleError(badInputError);

    expect(window.alert).toHaveBeenCalledWith("Bad request.");
  });

  it("should handle other errors by logging them to the console", () => {
    const unexpectedError = new Error("Unexpected error");
    spyOn(console, "error");

    errorHandler.handleError(unexpectedError);

    expect(console.error).toHaveBeenCalledWith("Error: Unexpected error");
    expect(console.error).toHaveBeenCalledWith(
      "Error Stack Trace: " + unexpectedError.stack
    );
  });

  it("should handle null error gracefully", () => {
    spyOn(console, "error");

    errorHandler.handleError(null);

    expect(console.error).toHaveBeenCalled();
  });
});

 // ng test --include=src/app/common/app-error-handler.spec.ts
