import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/pddikti/student_model.dart';
import 'package:getx_application/models/pddikti/university_model.dart';

class PddiktiService extends ApiInstance {
  Future<ServiceResult<List<PddiktiUniversityModel>>> findUniversitiesByName(
      String universityName) async {
    final response = await get(
      '/v1/pddikti/universities?university_name=$universityName',
    );
    if (response.status) {
      List<dynamic> dataList = response.data ?? [];
      List<PddiktiUniversityModel> universities = dataList
          .map((data) =>
              PddiktiUniversityModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(universities);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<PddiktiStudentModel>>> findStudentsByNim(
      String universityId, String nim) async {
    final response =
        await get('/v1/pddikti/students?university_id=$universityId&nim=$nim');
    if (response.status) {
      List<dynamic> dataList = response.data ?? [];

      List<PddiktiStudentModel> alumnis = dataList
          .map((data) =>
              PddiktiStudentModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(alumnis);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
