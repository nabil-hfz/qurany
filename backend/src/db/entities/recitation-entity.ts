import { Entity, Column, ManyToOne, JoinColumn, OneToOne } from 'typeorm';
import { LocalizedEntity } from './localized-entity';
import { FileEntity } from './file-entity';
import { ReciterEntity } from './reciter-entity';
import { AppBaseEntity } from './base-entity';

export enum RecitationTypes {
  Hafs = 1,
  Shoaba = 2,
}

export const RecitationTypesList = [
  RecitationTypes.Hafs,
  RecitationTypes.Shoaba,
];

@Entity({ name: 'recitation' })
export class RecitationEntity extends AppBaseEntity {
  @Column(type => LocalizedEntity)
  title!: LocalizedEntity;

  @OneToOne(() => FileEntity, {
    eager: true,
  })
  @JoinColumn()
  image!: FileEntity;

  @OneToOne(() => FileEntity, {
    eager: true,
  })
  @JoinColumn()
  audio!: FileEntity;

  @ManyToOne(() => ReciterEntity, {
    eager: true,
  })
  @JoinColumn()
  reciter!: ReciterEntity;

  @Column({
    type: "enum",
    enum: RecitationTypes,
    default: RecitationTypes.Hafs
  })
  recitationType!: RecitationTypes;

  @Column()
  khatmaId!: number;

  @Column({ default: 0 })
  sequence!: number;

  @Column({ default: 0 })
  totalDownloads!: number;

  @Column({ default: 0 })
  totalPlays!: number;

  @Column({ default: 0 })
  duration!: number;
}
