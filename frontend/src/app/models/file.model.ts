import { AppBaseModel } from './base.model';


export class FileEntity extends AppBaseModel {

    public url!: string;
    public size?: number;
    public mimetype?: string;
    public name?: string;
}
