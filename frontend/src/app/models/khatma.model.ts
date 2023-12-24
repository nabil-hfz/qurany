



import { AppBaseModel } from './base.model';
import { LocalizedModel } from './localized.model';
import { ReciterModel } from './reciter.model';

export class KhatmaModel extends AppBaseModel {

  public name!: LocalizedModel;
  public recitationType?: number;
  public totalDownloads: number = 0;
  public totalPlays: number = 0;
  public reciter?: ReciterModel;
}