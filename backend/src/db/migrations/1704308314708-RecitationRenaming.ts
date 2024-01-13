import { MigrationInterface, QueryRunner } from "typeorm";

export class RecitationRenaming1704308314708 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.renameTable('recitation', 'recitations');


        await queryRunner.renameColumn('recitations', 'createdAt', 'created_at');
        await queryRunner.renameColumn('recitations', 'updatedAt', 'updated_at');

        await queryRunner.renameColumn('recitations', 'recitationType', 'recitation_type');
        await queryRunner.renameColumn('recitations', 'khatmaId', 'khatma_id');

        await queryRunner.renameColumn('recitations', 'totalDownloads', 'total_downloads');
        await queryRunner.renameColumn('recitations', 'totalPlays', 'total_plays');
        await queryRunner.renameColumn('recitations', 'duration', 'duration_in_milli');

        await queryRunner.renameColumn('recitations', 'imageId', 'image_id');
        await queryRunner.renameColumn('recitations', 'audioId', 'audio_id');
        await queryRunner.renameColumn('recitations', 'reciterId', 'reciter_id');

        await queryRunner.renameColumn('recitations', 'titleAr', 'name_ar');
        await queryRunner.renameColumn('recitations', 'titleEn', 'name_en');

    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // Revert column renames
        await queryRunner.renameColumn('recitations', 'created_at', 'createdAt');
        await queryRunner.renameColumn('recitations', 'updated_at', 'updatedAt');
        await queryRunner.renameColumn('recitations', 'recitation_type', 'recitationType');
        await queryRunner.renameColumn('recitations', 'khatma_id', 'khatmaId');
        await queryRunner.renameColumn('recitations', 'total_downloads', 'totalDownloads');
        await queryRunner.renameColumn('recitations', 'total_plays', 'totalPlays');
        await queryRunner.renameColumn('recitations', 'duration_in_milli', 'duration');
        await queryRunner.renameColumn('recitations', 'image_id', 'imageId');
        await queryRunner.renameColumn('recitations', 'audio_id', 'audioId');
        await queryRunner.renameColumn('recitations', 'reciter_id', 'reciterId');
        await queryRunner.renameColumn('recitations', 'name_ar', 'titleAr');
        await queryRunner.renameColumn('recitations', 'name_en', 'titleEn');

        // Revert table rename
        await queryRunner.renameTable('recitations', 'recitation');
    }
}
