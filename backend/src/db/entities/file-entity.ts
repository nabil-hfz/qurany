import { Entity, Column } from 'typeorm';
import { AppBaseEntity } from './base-entity';

@Entity({ name: 'file' })
export class FileEntity extends AppBaseEntity {
    @Column()
    public url!: string;

    @Column()
    size!: number;

    @Column({ nullable: true })
    mimetype?: string;

    @Column({ nullable: true })
    name?: string;
}

// async function create(){
//     // Usage:
//     const file = new FileEntity();
//     file.name = 'John Doe';
//     await file.save();
  
//     const foundUser = await FileEntity.findOne({ where: { name: 'John Doe' } });
// }