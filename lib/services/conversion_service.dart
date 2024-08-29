import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';

class ConversionService extends ApiInstance {
  Future<ServiceResult<dynamic>> getConversionAlumni() async {
    final response = await get('/v1/conversion-submissions');

    if (response.status) {
      return ServiceResult.success(response.data);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> createConversionAlumni(
      Map<String, dynamic> body) async {
    final response = await post('/v1/conversion-submissions', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
