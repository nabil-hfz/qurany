import { Entity, Column, OneToOne, JoinColumn, ManyToMany, JoinTable } from 'typeorm';
import { FileEntity } from './file.entity';
import { AppBaseEntity } from './base.entity';
import { LanguageEntity } from './language.entity';
import { CategoryEntity } from './category.entity';

/**
 * Represents a file entry entity in the database for library feature.
 * Each file entry could have multiple categories linked to it. 
 * Allowing the users filtering the entries by category.
 * 
 * Extends `AppBaseEntity` to inherit standart colomns such as ID , creation and update timestamps.
 */
@Entity({ name: 'file_entries' })
export class FileEntryEntity extends AppBaseEntity {

  /**
   * The name of the file entry entity. It could be in any language.
   * The filed is required and it sould be null, used to store the actual name of the file.
   */
  @Column({ nullable: false })
  name!: string;

  /**
   * The description of the file entry entity. It could be in any language.
   * The filed is optional and used to store the description of the file.
   */
  @Column({ nullable: true })
  description?: string;

  /**
   * The language of the file entry entity.
   * The field is very important as it represents the actual language of the file if it has.
   * The field is optional.
   */
  @OneToOne(() => LanguageEntity, {
    eager: true,
    nullable: true
  })
  @JoinColumn()
  language?: LanguageEntity;


  /**
   * A collection fo categories associated with this file entry.
   * This relationship is many-to-many relationship as each file might have many categories
   * and each category is associated with multiple files.
   * This field is required and should not be null.
   * 
   * The `CategoryEntity` is the linked category entity.
   */
  @ManyToMany(() => CategoryEntity, {nullable: false})
  @JoinTable({
    name: 'file_entry_categories',
    joinColumn: {
      name: 'file_entry_id',
      referencedColumnName: 'id',
    },
    inverseJoinColumn: {
      name: 'category_id',
      referencedColumnName: 'id',
    }
  })
  categories?: CategoryEntity[];


  /**
   * Represeents the file itself from the database.
   * This fiels is required and has the actual info about the stored file in the storage.
   */
  @OneToOne(() => FileEntity, {
    eager: true,
    nullable: false,
  })
  @JoinColumn()
  file?: FileEntity;


  /**
   * Represeents the thumbnail of the stored file for this file entry.
   * This fields is optional and has the thumbnail of pdf, wrod, doc, docx, etc.
   */
  @OneToOne(() => FileEntity, {
    eager: true,
  })
  @JoinColumn()
  thumbnail?: FileEntity;


  /**
   * Represeents the total view of the file entry.
   * This fields is optional and has a default value of 0. It could be increased every time
   * the file entry is requested from the database.
   */
  @Column({ default: 0 })
  totalViews: number = 0;

  /**
   * Represents the total downloads of the file entry.
   * This fileds is optional and has a default value of 0. It could be increased every time
   * the file entry is downloaded.
   */
  @Column({ default: 0 })
  totalDownloads: number = 0;

}