import { LocalizedModel } from './localized.model';
import {   FileModel } from './file.model';
import { ReciterModel } from './reciter.model';
import { AppBaseModel } from './base.model';

export enum RecitationTypes {
  Hafs = 1,
  Shoaba = 2,
}

export const RecitationTypesList = [
  RecitationTypes.Hafs,
  RecitationTypes.Shoaba,
];


export class RecitationModel extends AppBaseModel {

  public title!: LocalizedModel;


  public image?: string;

  public audio?: string;

  public reciter!: ReciterModel;

  public recitationType!: RecitationTypes;


  public khatmaId!: number;


  public sequence?: number;


  public totalDownloads: number = 0;


  public totalPlays: number = 0;


  public duration: number = 0;
}
