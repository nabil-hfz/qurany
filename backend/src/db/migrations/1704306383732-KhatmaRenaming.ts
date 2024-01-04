import { MigrationInterface, QueryRunner } from "typeorm";

export class KhatmaRenaming1704306383732 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('khatma', 'khatmat');


        await queryRunner.renameColumn('khatmat', 'createdAt', 'created_at');
        await queryRunner.renameColumn('khatmat', 'updatedAt', 'updated_at');

        await queryRunner.renameColumn('khatmat', 'recitationType', 'recitation_type');
        await queryRunner.renameColumn('khatmat', 'totalDownloads', 'total_downloads');
        await queryRunner.renameColumn('khatmat', 'totalPlays', 'total_plays');

        await queryRunner.renameColumn('khatmat', 'reciterId', 'reciter_id');
        await queryRunner.renameColumn('khatmat', 'nameAr', 'name_ar');
        await queryRunner.renameColumn('khatmat', 'nameEn', 'name_en');

    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // Revert column renames
        await queryRunner.renameColumn('khatmat', 'created_at', 'createdAt');
        await queryRunner.renameColumn('khatmat', 'updated_at', 'updatedAt');

        await queryRunner.renameColumn('khatmat', 'recitation_type', 'recitationType');
        await queryRunner.renameColumn('khatmat', 'total_downloads', 'totalDownloads');
        await queryRunner.renameColumn('khatmat', 'total_plays', 'totalPlays');
        
        await queryRunner.renameColumn('khatmat', 'reciter_id', 'reciterId');
        await queryRunner.renameColumn('khatmat', 'name_ar', 'nameAr');
        await queryRunner.renameColumn('khatmat', 'name_en', 'nameEn');

        // Revert table rename
        await queryRunner.renameTable('khatmat', 'khatma');
    }

}
