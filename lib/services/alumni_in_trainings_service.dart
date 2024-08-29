import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/alumni_in_training/alumni_in_training_model.dart';

class AlumniInTrainingsService extends ApiInstance {
  Future<ServiceResult<List<AlumniInTrainingModel>>> getAlumniInTrainings(
      String id,
      {Map<String, String>? params}) async {
    final response = await get('/v1/training-posts/$id/alumni-in-trainings',
        queryParams: params);

    if (response.status) {
      final List<AlumniInTrainingModel> datas = [];

      for (final item in response.data) {
        datas.add(AlumniInTrainingModel.fromJson(item));
      }

      return ServiceResult.success(
        datas,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> createAlumniInTrainings(
      Map<String, dynamic> body) async {
    final response = await post('/v1/alumni-in-trainings', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
