/**
 * Represents a localized model with support for Arabic and English languages.
 */
export class LocalizedModel {

  /**
   * The Arabic language value.
   */
  public ar?: string;

  /**
   * The English language value.
   */
  public en?: string;

  /**
   * Gets the current value based on the preferred language (Arabic or English).
   * If both values are undefined, an empty string is returned.
   *
   * @returns The current value based on the preferred language.
   */
  get currentValue(): string {
    if (this.ar != null)
      return this.ar;

    if (this.en != null)
      return this.en;
    return ''
  }
}
