import 'package:getx_application/common/models/user_comment.dart';

class TrainingPostCommentModel {
  final int? id;
  final UserCommentModel? user;
  final String? comment;
  final String? createdAt;

  TrainingPostCommentModel({
    this.id,
    this.user,
    this.comment,
    this.createdAt,
  });

  factory TrainingPostCommentModel.fromJson(Map<String, dynamic> data) {
    return TrainingPostCommentModel(
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
