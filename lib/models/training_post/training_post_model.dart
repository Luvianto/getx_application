import 'package:getx_application/models/enums.dart';

class TrainingPostModel {
  final int? id;
  final TrainingInstitution? trainingInstitution;
  FieldEnum? field;
  String? title;
  String? thumbnailUrl;
  String? description;
  int? point;
  final int? likesTotal;
  final int? commentsTotal;
  bool? isTraining;
  final int? joinedCount;
  final bool? isJoined;
  final bool? isLiked;
  bool? isClosed;
  final String? createdAt;
  final String? updatedAt;

  TrainingPostModel({
    this.id,
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
    this.isClosed,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainingPostModel.fromJson(Map<String, dynamic> data) {
    return TrainingPostModel(
      id: data['id'],
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
      isClosed: data['is_closed'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field!.toJson(),
      'title': title,
      'thumbnail_url': thumbnailUrl,
      'description': description,
      'point': point,
      'is_training': isTraining,
      'is_closed': isClosed ?? false,
    };
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
      institutionName: data['institution_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution_name': institutionName,
    };
  }
}
