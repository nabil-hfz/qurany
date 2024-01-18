import { LocalizedModel } from '../models/localized.model';

/**
 * Utility class for handling translation or localization.
 */
export abstract class AppTranslation {
  /**
   * Get the Arabic translation from a LocalizedModel.
   * @param localizedModel - The LocalizedModel object containing translations.
   * @returns The Arabic translation or an empty string if not available.
   */
  static getTranslation(localizedModel?: LocalizedModel): string {
    if (!localizedModel) {
      return '';
    }

    // Attempt to retrieve the Arabic translation, defaulting to an empty string if not available.
    return localizedModel.ar ?? '';
  }
}
