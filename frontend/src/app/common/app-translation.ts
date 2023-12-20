import { LocalizedModel } from './../models/localized.model';
export function getTranslation(localizedModel?: LocalizedModel) {

    if (!localizedModel) return '';
    return localizedModel.ar ?? '';
}