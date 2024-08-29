import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/training_post/training_post_model.dart';
import 'package:getx_application/models/training_post/training_post_comment_model.dart';

class TrainingPostService extends ApiInstance {
  Future<ServiceResult<List<TrainingPostModel>>> fetchTrainingPost(
      Map<String, String> params) async {
    final response = await get('/v1/training-posts/', queryParams: params);

    if (response.status) {
      final List<TrainingPostModel> posts = [];

      for (final item in response.data) {
        posts.add(TrainingPostModel.fromJson(item));
      }

      return ServiceResult.success(
        posts,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<TrainingPostModel>> fetchTrainingPostDetails(
      String id) async {
    final response = await get('/v1/training-posts/$id');

    if (response.status) {
      return ServiceResult.success(TrainingPostModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<TrainingPostCommentModel>>>
      fetchTrainingPostComments(String id) async {
    final response = await get('/v1/training-posts/$id/comments');

    if (response.status) {
      final List<TrainingPostCommentModel> comments = [];

      for (final item in response.data) {
        comments.add(TrainingPostCommentModel.fromJson(item));
      }

      return ServiceResult.success(comments);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> createTrainingPostComment(
      String id, Object data) async {
    final response = await post('/v1/training-posts/$id/comments', data);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateTrainingPost(
      String id, TrainingPostModel data) async {
    final response = await put('/v1/training-posts/$id', data);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateTrainingPostStatus(
      String id, bool status) async {
    final response = await patch('/v1/training-posts/$id', {
      'is_closed': status,
    });

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateTrainingPostLike(int id, int like) async {
    final response = await patch('/v1/training-posts/$id/likes', {
      'Action': like,
    });

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
