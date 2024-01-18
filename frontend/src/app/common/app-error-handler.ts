import { ErrorHandler } from "@angular/core";
import { AppNotFoundError } from "./not-found-error";
import { AppBadInputError } from "./bad-input";

/**
 * Custom error handler class that implements the ErrorHandler interface.
 * This handler provides custom error handling for specific error types.
 */
export class AppErrorHandler implements ErrorHandler {
  /**
   * Handles errors based on their types.
   * @param error - The error to handle.
   */
  handleError(error: any): void {
    if (error instanceof AppNotFoundError) {
      // Handle the 'Not Found' error by displaying an alert.
      alert('This item has already been deleted or not found.');
    } else if (error instanceof AppBadInputError) {
      // Handle the 'Bad Input' error by displaying an alert.
      alert('Bad request.');
    } else {
      // Handle other unexpected errors by logging them to the console.
      console.error('Error: ' + error.message);
      console.error('Error Stack Trace: ' + error.stack);
    }
  }
}
