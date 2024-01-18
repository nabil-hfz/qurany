import { LocalizedModel } from '../models/localized.model';
import { AppTranslation } from './app-translation';

describe('AppTranslation', () => {
  it('should return an empty string when no LocalizedModel is provided', () => {
    const result = AppTranslation.getTranslation();
    expect(result).toEqual('');
  });

  it('should return the Arabic translation if available in LocalizedModel', () => {
    const localizedModel = new LocalizedModel();
    localizedModel.ar = 'مرحباً';

    const result = AppTranslation.getTranslation(localizedModel);

    expect(result).toEqual('مرحباً');
  });

  it('should return an empty string if Arabic translation is not available in LocalizedModel', () => {
    const localizedModel = new LocalizedModel();
    localizedModel.en = 'Hello';

    const result = AppTranslation.getTranslation(localizedModel);

    expect(result).toEqual('');
  });
});

describe('LocalizedModel', () => {
  it('should return the Arabic value if available', () => {
    const localizedModel = new LocalizedModel();
    localizedModel.ar = 'مرحباً';

    const result = localizedModel.currentValue;

    expect(result).toEqual('مرحباً');
  });

  it('should return the default value "Nabil" if Arabic value is not available', () => {
    const localizedModel = new LocalizedModel();

    const result = localizedModel.currentValue;

    expect(result).toEqual('Nabil');
  });
});

 // ng test --include=src/app/common/app-translation.spec.ts
