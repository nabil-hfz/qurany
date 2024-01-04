import { Column } from 'typeorm';

export class LocalizedEntity {
  @Column({ nullable: true })
  ar?: string;

  @Column({ nullable: true })
  en?: string;
}
