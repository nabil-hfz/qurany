
export class LocalizedModel {

  public ar?: string;

  public en?: string;


  get currentValue(): string  {
   return this.ar ||  'Nabil';

  }
}
