import { AppBaseModel } from './base.model';


export class FileModel extends AppBaseModel {

    public url!: string;
    public size?: number;
    public mimetype?: string;
    public name?: string;
}
