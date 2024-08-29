import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/application/application_model.dart';

class ApplicationService extends ApiInstance {
  Future<ServiceResult<List<ApplicationModel>>> fetchApplications(
      {Map<String, String>? params}) async {
    final response = await get('/v1/applications', queryParams: params);

    if (response.status) {
      final List<ApplicationModel> datas = [];

      for (final item in response.data) {
        datas.add(ApplicationModel.fromJson(item));
      }

      return ServiceResult.success(
        datas,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<ApplicationModel>> fetchApplicationsByID(
      String id) async {
    final response = await get('/v1/applications/$id');

    if (response.status) {
      return ServiceResult.success(ApplicationModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<ApplicationModel>>> fetchApplicationsByVacancyID(
      String id) async {
    final response = await get('/v1/vacancies/$id/applications');

    if (response.status) {
      final List<ApplicationModel> datas = [];

      for (final item in response.data) {
        datas.add(ApplicationModel.fromJson(item));
      }

      return ServiceResult.success(
        datas,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> postApplication(
      Map<String, dynamic> body) async {
    final response = await post('/v1/applications', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> updateApplicationStatus(
      Map<String, dynamic> body, id) async {
    final response = await patch('/v1/applications/$id/status', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
