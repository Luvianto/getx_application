import 'package:getx_application/common/models/user_comment.dart';

class VacancyCommentModel {
  final int? id;
  final UserCommentModel? user;
  final String? comment;
  final String? createdAt;

  VacancyCommentModel({
    this.id,
    this.user,
    this.comment,
    this.createdAt,
  });

  factory VacancyCommentModel.fromJson(Map<String, dynamic> data) {
    return VacancyCommentModel(
      id: data['id'],
      user: UserCommentModel.fromJson(data['user']),
      comment: data['comment'],
      createdAt: data['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user!.toJson(),
      'comment': comment,
      'created_at': createdAt,
    };
  }
}
