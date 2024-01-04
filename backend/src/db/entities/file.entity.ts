import { Entity, Column } from 'typeorm';
import { AppBaseEntity } from './base.entity';
/**
 * Represents a file entity in the database.
 *
 * This entity is used to store information about various files, such as their URLs,
 * sizes, MIME types, and names. It extends the `AppBaseEntity` which may include
 * common fields like ID, created at, and updated at timestamps.
 */
@Entity({ name: 'files' })
export class FileEntity extends AppBaseEntity {
    /**
     * The URL where the file is located.
     * This field is required and must be a valid URL string.
     */
    @Column()
    public url!: string;

    /**
     * The size of the file in bytes.
     * This field is required.
     */
    @Column()
    size!: number;

    /**
     * The MIME type of the file.
     * This field is optional and used to indicate the nature and format of the file.
     */
    @Column({ nullable: true })
    mimeType?: string;

    /**
     * The name of the file.
     * This field is optional and used to store the original name of the file.
     */
    @Column({ nullable: true })
    name?: string;

    /**
     * The thumbnail of the file.
     * This field is optional and used to store the thumbnail of the file, if it has.
     */
    // @OneToOne(() => FileEntity)
    // @JoinColumn({ name: 'thumbnail_id' })
    // thumbnail?: FileEntity;
}

