import { MigrationInterface, QueryRunner } from "typeorm";

export class ReciterRenamingyy1704308114712 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('reciter', 'reciters');


        await queryRunner.renameColumn('reciters', 'createdAt', 'created_at');
        await queryRunner.renameColumn('reciters', 'updatedAt', 'updated_at');

        await queryRunner.renameColumn('reciters', 'recitationTypes', 'recitation_types');
        await queryRunner.renameColumn('reciters', 'totalPlays', 'total_plays');
        await queryRunner.renameColumn('reciters', 'totalDownloads', 'total_downloads');

        await queryRunner.renameColumn('reciters', 'numberOfKhatmat', 'number_of_khatmat');
        await queryRunner.renameColumn('reciters', 'imageId', 'image_id');

        await queryRunner.renameColumn('reciters', 'reciterIndex', 'reciter_index');
        await queryRunner.renameColumn('reciters', 'bioAr', 'bio_ar');
        await queryRunner.renameColumn('reciters', 'bioEn', 'bio_en');

        await queryRunner.renameColumn('reciters', 'nameAr', 'name_ar');
        await queryRunner.renameColumn('reciters', 'nameEn', 'name_en');

    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // Revert column renames
        await queryRunner.renameColumn('reciters', 'created_at', 'createdAt');
        await queryRunner.renameColumn('reciters', 'updated_at', 'updatedAt');
        await queryRunner.renameColumn('reciters', 'recitation_types', 'recitationTypes');
        await queryRunner.renameColumn('reciters', 'total_plays', 'totalPlays');
        await queryRunner.renameColumn('reciters', 'total_downloads', 'totalDownloads');
        await queryRunner.renameColumn('reciters', 'number_of_khatmat', 'numberOfKhatmat');
        await queryRunner.renameColumn('reciters', 'image_id', 'imageId');
        await queryRunner.renameColumn('reciters', 'reciter_index', 'reciterIndex');
        await queryRunner.renameColumn('reciters', 'bio_ar', 'bioAr');
        await queryRunner.renameColumn('reciters', 'bio_en', 'bioEn');
        await queryRunner.renameColumn('reciters', 'name_ar', 'nameAr');
        await queryRunner.renameColumn('reciters', 'name_en', 'nameEn');

        // Revert table rename
        await queryRunner.renameTable('reciters', 'reciter');
    }
}
