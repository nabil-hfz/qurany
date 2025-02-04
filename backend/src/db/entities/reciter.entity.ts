import { Entity, Column, OneToOne, JoinColumn } from 'typeorm';
import { FileEntity } from './file.entity';
// import { LocalizedEntity } from './localized.entity';
import { AppBaseEntity } from './base.entity';
import { RecitationTypes } from '../recitation-types';

@Entity({ name: 'reciters' })
export class ReciterEntity extends AppBaseEntity {

  // @Column({ type: 'jsonb', nullable: true })
  // name?: LocalizedEntity;

  @Column({ type: 'jsonb', nullable: true })
  name?: { [key: string]: string };


  @Column({ type: 'jsonb', nullable: true })
  bio?: { [key: string]: string };

  // @Column({ type: 'jsonb', nullable: true })
  // bio?: LocalizedEntity;

  @OneToOne(() => FileEntity, { eager: true })
  @JoinColumn({ name: 'image_id' })
  image?: FileEntity;

  // @Column("int", { array: true, default: [RecitationTypes.Hafs] })
  // recitationTypes!: number[];

  @Column({
    type: "int",
    array: true,
    // default: () => `'{${RecitationTypes.Hafs}}'` // Correctly formatted default value
    default: () => [RecitationTypes.Hafs]
  })
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