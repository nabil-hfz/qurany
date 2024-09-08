

import { AppBaseEntity } from './base.entity';
import { Entity } from 'typeorm/decorator/entity/Entity';
import { Column } from 'typeorm/decorator/columns/Column';

@Entity({ name: 'languages' })
export class LanguageEntity extends AppBaseEntity {

  @Column({ nullable: false, unique: true, })
  name!: string;


  @Column({ nullable: false, unique: true, })
  language_code!: string;
}