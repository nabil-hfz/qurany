import { PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, BaseEntity } from 'typeorm';

/**
 * Base entity class for TypeORM. This class includes common fields like
 * `createdAt` and `updatedAt`, and can be extended by other entity classes.
 */
export abstract class AppBaseEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn({ nullable: true, default: null })
  updatedAt?: Date;

}
