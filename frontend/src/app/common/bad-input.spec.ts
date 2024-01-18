import { TestBed } from '@angular/core/testing';
import { AppErrorHandler } from './app-error-handler';
import { AppNotFoundError } from './not-found-error';
import { AppBadInputError } from './bad-input';

describe('AppErrorHandler', () => {
  let errorHandler: AppErrorHandler;


  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [AppErrorHandler], 
    });
    errorHandler = TestBed.inject(AppErrorHandler);
  });

  it('should create', () => {
    expect(errorHandler).toBeTruthy();
  });

  it('should handle AppNotFoundError', () => {
    spyOn(window, 'alert');
    const error = new AppNotFoundError();

    errorHandler.handleError(error);

    expect(window.alert).toHaveBeenCalledWith('This item has already been deleted or not found.');
  });

  it('should handle AppBadInputError', () => {
    spyOn(window, 'alert');
    const error = new AppBadInputError();

    errorHandler.handleError(error);

    expect(window.alert).toHaveBeenCalledWith('Bad request.');
  });

  it('should handle other errors', () => {
    spyOn(console, 'error');
    const error = new Error('Some unexpected error');

    errorHandler.handleError(error);

    expect(console.error).toHaveBeenCalledWith('Error: Some unexpected error');
    expect(console.error).toHaveBeenCalledWith('Error: ' + error.stack);
  });
});

// ng test --include=src/app/common/bad-input.spec.ts
