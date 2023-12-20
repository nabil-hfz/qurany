



import { BaseFilter } from './filters/base.filter';
import { AppBaseModel } from './base.model';
import { LocalizedModel } from './localized.model';
import { ReciterModel } from './reciter.model';

export class KhatmaModel extends AppBaseModel {

  public name!: LocalizedModel;
  public recitationType?: number;
  public totalDownloads?: number;
  public totalPlays?: number;
  public reciter?: ReciterModel;
}