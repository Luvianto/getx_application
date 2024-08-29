import 'package:getx_application/models/enums.dart';

class TrainingPostModel {
  final TrainingInstitution? trainingInstitution;
  final FieldEnum? field;
  final String? title;
  final String? thumbnailUrl;
  final String? description;
  final int? point;
  final int? likesTotal;
  final int? commentsTotal;
  final bool? isTraining;
  final int? joinedCount;
  final bool? isJoined;
  final bool? isLiked;
  final String? createdAt;
  final String? updatedAt;

  TrainingPostModel({
    this.trainingInstitution,
    this.field,
    this.title,
    this.thumbnailUrl,
    this.description,
    this.point,
    this.likesTotal,
    this.commentsTotal,
    this.isTraining,
    this.joinedCount,
    this.isJoined,
    this.isLiked,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainingPostModel.fromJson(Map<String, dynamic> data) {
    return TrainingPostModel(
      trainingInstitution:
          TrainingInstitution.fromJson(data['training_institution']),
      field: FieldEnum.fromJson(data['field']),
      title: data['title'],
      thumbnailUrl: data['thumbnail_url'],
      description: data['description'],
      point: data['point'],
      likesTotal: data['likes_total'],
      commentsTotal: data['comments_total'],
      isTraining: data['is_training'],
      joinedCount: data['joined_count'],
      isJoined: data['is_joined'],
      isLiked: data['is_liked'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
    );
  }
}

class TrainingInstitution {
  final int id;
  final String institutionName;

  TrainingInstitution({
    required this.id,
    required this.institutionName,
  });

  factory TrainingInstitution.fromJson(Map<String, dynamic> data) {
    return TrainingInstitution(
      id: data['id'],
      institutionName: data['institution_name'] as String,
    );
  }
}
