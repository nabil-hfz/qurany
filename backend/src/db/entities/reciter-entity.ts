import { Entity, Column, OneToOne, JoinColumn } from 'typeorm';
import { FileEntity } from './file-entity';
import { LocalizedEntity } from './localized-entity';
import { AppBaseEntity } from './base-entity';

// import { RecitationTypes } from './recitation-entity';
// RecitationTypes.Hafs;

@Entity({ name: 'reciters' })
export class ReciterEntity extends AppBaseEntity {

  @Column(type => LocalizedEntity)
  name?: LocalizedEntity;

  @Column(type => LocalizedEntity)
  bio?: LocalizedEntity;

  @OneToOne(() => FileEntity, {
    eager: true,
  })
  @JoinColumn()
  image?: FileEntity;

  @Column("int", { array: true, default: [1] })
  recitationTypes!: number[];

  @Column({ nullable: false })
  reciterIndex!: number;

  @Column({ default: 0 })
  totalPlays: number = 0;

  @Column({ default: 0 })
  totalDownloads: number = 0;

  @Column({ default: 0 })
  numberOfKhatmat: number = 0;
}