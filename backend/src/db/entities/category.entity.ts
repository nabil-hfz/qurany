
import { AppBaseEntity } from './base.entity';
import { Entity } from 'typeorm/decorator/entity/Entity';
import { Column } from 'typeorm/decorator/columns/Column';
import { LocalizedEntity } from './localized.entity';
import { ManyToMany } from 'typeorm';
import { FileEntryEntity } from './file-entiry.entity';
/**
 * Represents a category entity in the database.
 * Each category can be linked to multiple file entries, allowing for categorization
 * of various files and documents within the system.
 *
 * Extends the `AppBaseEntity` to inherit standard columns like ID, creation, and update timestamps.
 */
@Entity({ name: 'categories' })
export class CategoryEntity extends AppBaseEntity {

  /**
   * The localized name of the category.
   * This field is required and must be unique across all categories.
   * The `LocalizedEntity` type allows for storing names in different languages.
   */
  @Column({ type: 'jsonb', nullable: true })
  name!: LocalizedEntity;

  /**
   * A collection of file entries associated with this category.
   * This is a many-to-many relationship as each category can be linked to multiple file entries
   * and each file entry can belong to multiple categories.
   * 
   * The `FileEntryEntity` represents the linked file entries.
   */
  @ManyToMany(() => FileEntryEntity)
  fileEntries?: FileEntryEntity[];
}
