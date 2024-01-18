/**
 * Custom error class that can wrap and encapsulate original errors.
 */
export class AppError {
    /**
     * Creates an instance of the `AppError` class.
     * @param originalError - The original error that is being encapsulated.
     */
    constructor(public originalError?: any) {}
  }
  