import { MigrationInterface, QueryRunner } from "typeorm";

export class FilesRenaming1704306693010 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('file','files');

        await queryRunner.renameColumn('files', 'createdAt', 'created_at');
        await queryRunner.renameColumn('files', 'updatedAt', 'updated_at');

        await queryRunner.renameColumn('files', 'mimetype', 'mime_type');

    }

    public async down(queryRunner: QueryRunner): Promise<void> {

        await queryRunner.renameColumn('files', 'created_at', 'createdAt');
        await queryRunner.renameColumn('files', 'updated_at', 'updatedAt');
        await queryRunner.renameColumn('files', 'mime_type', 'mimetype');

        await queryRunner.renameTable('files','file');

    }

}
