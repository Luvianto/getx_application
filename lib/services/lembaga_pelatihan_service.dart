import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/post/training_post_model.dart';

class LembagaPelatihanService extends ApiInstance {
  Future<ServiceResult<TrainingPostModel>> registerLembagaPelatihan(
      Object body) async {
    final response = await post('/v1/signup/66b20bda8bc22888e74f9ca1', body);

    if (response.status) {
      return ServiceResult.success(TrainingPostModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<TrainingPostModel>> getLembagaPelatihanById(
      String id) async {
    final response = await get('/v1/training-institutions/$id');

    if (response.status) {
      return ServiceResult.success(TrainingPostModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateLembagaPelatihan(Object body) async {
    final response = await put('/v1/training-institutions', body);
    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> postTraining(Object body) async {
    final response = await post('/v1/training-posts', body);
    print('Data: ${response.data}');
    if (response.status) {
      return ServiceResult.success(response.data);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
