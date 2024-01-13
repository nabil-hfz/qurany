import { LocalizedModel } from './localized.model';
import { RecitationTypes } from './recitation.model';
import { AppBaseModel } from './base.model';


export class ReciterModel extends AppBaseModel {

  name!: LocalizedModel;

  bio!: LocalizedModel;

  image?:  string;

  recitationTypes?: RecitationTypes[];


  totalPlays: number = 0;


  totalDownloads: number = 0;


  numberOfKhatmat: number = 0;
}