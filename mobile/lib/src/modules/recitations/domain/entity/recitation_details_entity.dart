import 'recitation_entity.dart';

// final int? audioFileSizeInByte;
// final int? totalDownloads;
// final int? totalPlays;
// final DateTime? createdAt;
//
// RecitationDetailsModel({
//   super.id,
//   super.khatmaId,
//   super.title,
//   super.audio,
//   super.image,
//   int? durationInSecond,
//   this.audioFileSizeInByte,
//   this.totalDownloads,
//   this.totalPlays,
//   this.createdAt,
// });

class RecitationDetailsEntity extends RecitationEntity {
  final int audioFileSizeInByte;
  final int totalDownloads;
  final int totalPlays;
  final DateTime? createdAt;

  const RecitationDetailsEntity({
    required super.id,
    required super.khatmaId,
    super.title,
    super.audio,
    super.image,
    required super.durationInSecond,
    required this.audioFileSizeInByte,
    required this.totalDownloads,
    required this.totalPlays,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        super.id,
        super.khatmaId,
        super.title,
        super.audio,
        super.image,
        super.durationInSecond,
        audioFileSizeInByte,
        totalDownloads,
        totalPlays,
        createdAt,
      ];
}
