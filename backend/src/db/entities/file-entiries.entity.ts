import { Entity, Column, OneToOne, JoinColumn, ManyToMany, JoinTable } from 'typeorm';
import { FileEntity } from './file.entity';
import { AppBaseEntity } from './base.entity';
import { LanguageEntity } from './language.entity';
import { CategoryEntity } from './category.entity';
/**
 * Represents a file entry entity in the database for the library feature.
 * Each file entry can have multiple categories, allowing users to filter entries by category.
 * 
 * Extends `AppBaseEntity` to inherit standard columns such as ID, creation, and update timestamps.
 */
@Entity({ name: 'file_entries' })
export class FileEntryEntity extends AppBaseEntity {

  /**
   * The title of the file entry. This field is required and cannot be null.
   * Used to store the title of the file, which can be in any language.
   */
  @Column({ nullable: false })
  title!: string;

  /**
   * An optional description for the file entry, providing additional context or details.
   * Can be in any language.
   */
  @Column({ nullable: true })
  description?: string;

  /**
   * The language of the file entry. This field is optional but important,
   * as it represents the actual language of the file's content.
   */
  @OneToOne(() => LanguageEntity, { eager: true, nullable: true })
  @JoinColumn()
  language?: LanguageEntity;

  /**
   * The categories associated with this file entry. It's a many-to-many relationship,
   * as each file can belong to multiple categories, and each category can include multiple files.
   */
  @ManyToMany(() => CategoryEntity, { nullable: false })
  @JoinTable({
    name: 'file_entry_categories',
    joinColumn: { name: 'file_entry_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'category_id', referencedColumnName: 'id' }
  })
  categories?: CategoryEntity[];

  /**
   * Represents the actual file associated with this entry.
   * This field is required and links to the `FileEntity` containing details about the stored file.
   */
  @OneToOne(() => FileEntity, { eager: true, nullable: false })
  @JoinColumn()
  file?: FileEntity;

  /**
   * An optional thumbnail image for the file entry, useful for visual representation in listings.
   */
  @OneToOne(() => FileEntity, { eager: true })
  @JoinColumn()
  thumbnail?: FileEntity;

  /**
   * The total number of views for this file entry. Defaults to 0 and increments with each view.
   */
  @Column({ default: 0 })
  totalViews: number = 0;

  /**
   * The total number of downloads for this file entry. Defaults to 0 and increments with each download.
   */
  @Column({ default: 0 })
  totalDownloads: number = 0;
}
