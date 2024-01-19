import { AppError } from './app-error';

/**
 * Custom error class representing resource not found errors.
 * Extends the base AppError class.
 */
export class AppNotFoundError extends AppError {
  constructor() {
    super();
  }
}
