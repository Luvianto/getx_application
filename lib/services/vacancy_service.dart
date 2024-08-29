import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/vacancy/vacancy_comment_model.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';

class VacancyService extends ApiInstance {
  Future<ServiceResult<List<VacancyModel>>> fetchVacancies(
      {Map<String, String>? params}) async {
    final response = await get('/v1/vacancies', queryParams: params);

    if (response.status) {
      final List<VacancyModel> datas = [];

      for (final item in response.data) {
        datas.add(VacancyModel.fromJson(item));
      }

      return ServiceResult.success(
        datas,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<VacancyModel>> fetchVacancy(int id) async {
    // print(id);
    // String stringId = id.toString();
    final response = await get('/v1/vacancies/$id');

    if (response.status) {
      // print(response.data);
      return ServiceResult.success(VacancyModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> postVacancy(Map<String, dynamic> body) async {
    final response = await post('/v1/vacancies', body);
    // print('Data: ${response.message}');
    // print('Data: ${response.data}');
    if (response.status) {
      return ServiceResult.success(response.data);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<VacancyCommentModel>>> fetchVacancyComments(
      String id) async {
    final response = await get('/v1/vacancies/$id/comments');

    if (response.status) {
      final List<VacancyCommentModel> comments = [];

      for (final item in response.data) {
        comments.add(VacancyCommentModel.fromJson(item));
      }

      return ServiceResult.success(comments);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> createVacancyComment(
      String id, Object data) async {
    final response = await post('/v1/vacancies/$id/comments', data);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateVacancyLike(int id, int like) async {
    final response = await patch('/v1/vacancies/$id/likes', {
      'Action': like,
    });

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
