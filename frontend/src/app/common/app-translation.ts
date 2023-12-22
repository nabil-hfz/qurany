import { LocalizedModel } from './../models/localized.model';

export abstract class AppTranslation {
    static getTranslation(localizedModel?: LocalizedModel) {

        if (!localizedModel) return '';
        return localizedModel.ar ?? '';
    }
}
