import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/models/pddikti/student_model.dart';

class AlumniService extends ApiInstance {
  Future<ServiceResult<AlumniModel>> registerAlumni(Object body) async {
    final response = await post('/v1/signup/66b20bdafee1027f5433c3e4', body);

    if (response.status) {
      return ServiceResult.success(AlumniModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<AlumniModel>> getAlumniById(String id) async {
    final response = await get('/v1/alumnis/$id');

    if (response.status) {
      return ServiceResult.success(AlumniModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> getAlumnis(Map<String, String> params) async {
    final response = await get('/v1/alumnis', queryParams: params);

    if (response.status) {
      final List<AlumniModel> alumnis = [];

      for (final item in response.data) {
        alumnis.add(AlumniModel.fromJson({
          "id": item['id'],
          "pddikti_student_id": item['pddikti_student_id'] ?? '',
          "name": item['name'] ?? '',
          "university_name": item['university_name'] ?? '',
          "gpa": item['gpa'].toDouble() ?? 0.0,
          "graduation_date": item['graduation_date'] ?? '',
          "fields": item['fields'] == null
              ? ([] as List).map((field) => FieldEnum.fromJson(field)).toList()
              : (item['fields'] as List)
                  .map((field) => FieldEnum.fromJson(field))
                  .toList(),
          "major": item['major'] ?? '',
          "focus_field": item['focus_field'] == null
              ? {"id": '', 'name': ''}
              : FieldEnum.fromJson(item['focus_field']),
          "user": item["user"],
          "pddiktiData": item["pddikti_data"] != null
              ? PddiktiStudentModel.fromJson(item["pddikti_data"])
              : null,
        }));
      }

      return ServiceResult.success(
        alumnis,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updateAlumni(Object body) async {
    final response = await put('/v1/alumnis', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> getDashboardAlumni() async {
    final response = await get('/v1/dashboard/alumni');

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
