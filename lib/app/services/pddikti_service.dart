import 'package:getx_application/app/chore/handler/service_result.dart';
import 'package:getx_application/app/chore/instance/api_instance.dart';
import 'package:getx_application/app/data/models/pddikti/alumni_pddikti_model.dart';
import 'package:getx_application/app/data/models/pddikti/university_pddikti_model.dart';

class PddiktiService extends ApiInstance {
  Future<ServiceResult<List<UniversityPddiktiModel>>> findUniversitiesByName(
      String universityName) async {
    final response = await get(
      '/v1/pddikti/universities?university_name=$universityName',
    );
    if (response.status) {
      List<dynamic> dataList = response.data ?? [];
      List<UniversityPddiktiModel> universities = dataList
          .map((data) =>
              UniversityPddiktiModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(universities);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<AlumniPddiktiModel>>> findStudentsByNim(
      String universityId, String nim) async {
    final response =
        await get('/v1/pddikti/students?university_id=$universityId&nim=$nim');
    if (response.status) {
      List<dynamic> dataList = response.data ?? [];

      List<AlumniPddiktiModel> alumnis = dataList
          .map((data) =>
              AlumniPddiktiModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(alumnis);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
