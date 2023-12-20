



import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { AppBaseEntity } from './base-entity';
import { LocalizedEntity } from './localized-entity';
import { ReciterEntity } from './reciter-entity';

@Entity({ name: 'khatma' })
export class KhatmaEntity extends AppBaseEntity {

  @Column(type => LocalizedEntity)
  name!: LocalizedEntity;

  @Column()
  recitationType!: number;

  @Column({ default: 0 })
  totalDownloads!: number;

  @Column({ default: 0 })
  totalPlays!: number;

  // @ManyToOne(() => Author, (author) => author.photos)

  @ManyToOne((type) => ReciterEntity, //(reciter) => reciter.image,
   {
    eager: true,
  })
  @JoinColumn()
  reciter?: ReciterEntity;
}


// export interface IKhatmaModel extends IBaseModel {
//     name: ILocalizedModel;
//     recitationType: number;
//     totalDownloads: number;
//     totalPlays: number;
//     reciter: IReciterModel;
// }

// export const KhatmaModelSchema = new Schema<IKhatmaModel>({
//     ...BaseModelSchema.obj,
//     name: { type: LocalizedModelSchema, required: true },
//     recitationType: { type: Number, default: 0 },
//     totalDownloads: { type: Number, default: 0 },
//     totalPlays: { type: Number, default: 0 },
//     reciter: { type: Schema.Types.ObjectId, ref: 'Reciter', required: true },

// });


// export const KhatmaModel = mongoose.model<IKhatmaModel>('Khatma', KhatmaModelSchema);
