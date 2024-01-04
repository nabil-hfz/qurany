import { Entity, Column } from 'typeorm';
import { AppBaseEntity } from './base.entity';

@Entity({ name: 'files' })
export class FileEntity extends AppBaseEntity {
    @Column()
    public url!: string;

    @Column()
    size!: number;

    @Column({ nullable: true })
    mimeType?: string;

    @Column({ nullable: true })
    name?: string;
}