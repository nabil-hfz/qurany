import { Entity, Column, ManyToOne, JoinColumn, OneToOne } from 'typeorm';
// import { LocalizedEntity } from './localized.entity';
import { FileEntity } from './file.entity';
import { ReciterEntity } from './reciter.entity';
import { AppBaseEntity } from './base.entity';
import { RecitationTypes } from '../recitation-types';



@Entity({ name: 'recitations' })
export class RecitationEntity extends AppBaseEntity {

  // @Column({ type: 'jsonb', nullable: true })
  // name!: LocalizedEntity;

  @Column({ type: 'jsonb', nullable: true })
  name?: { [key: string]: string };

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
    type: "int",
    default: RecitationTypes.Hafs // Assuming RecitationTypes.Hafs is 1
  })
  recitationType!: number;

  @Column()
  khatmaId!: number;

  @Column({ default: 0 })
  sequence!: number;

  @Column({ default: 0 })
  totalDownloads!: number;

  @Column({ default: 0 })
  totalPlays!: number;

  @Column({ default: 0 })
  durationInMilli!: number;
}
