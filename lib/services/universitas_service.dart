import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/university/university_model.dart';

class UniversitasService extends ApiInstance {
  Future<ServiceResult<UniversityModel>> registerUniversitas(
      Object body) async {
    final response = await post('/v1/signup/66b20dd34988b31974cefde6', body);

    if (response.status) {
      return ServiceResult.success(UniversityModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<UniversityModel>> getUniversitasById(String id) async {
    final response = await get('/v1/universities/$id');

    if (response.status) {
      return ServiceResult.success(UniversityModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateUniversitas(Object body) async {
    final response = await put('/v1/universities', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
