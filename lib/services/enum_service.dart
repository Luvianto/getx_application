import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/enums.dart';

class EnumService extends ApiInstance {
  Future<ServiceResult<List<FieldEnum>>> fetchFields() async {
    final response = await get('/v1/enums/fields');

    if (response.status) {
      List<dynamic> dataList = response.data;
      List<FieldEnum> fields = dataList
          .map((data) => FieldEnum.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(fields);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<CompanyType>>> fetchCompanyType() async {
    final response = await get('/v1/enums/company-types');

    if (response.status) {
      List<dynamic> dataList = response.data;
      List<CompanyType> companyTypes = dataList
          .map((data) => CompanyType.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(companyTypes);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<LevelEnum>>> fetchLevel() async {
    final response = await get('/v1/enums/skill-levels');

    if (response.status) {
      final List<LevelEnum> datas = [];

      for (final item in response.data) {
        datas.add(LevelEnum.fromJson(item));
      }

      return ServiceResult.success(datas);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<JobType>>> fetchJobTypes() async {
    final response = await get('/v1/enums/job-types');

    if (response.status) {
      List<dynamic> dataList = response.data;
      List<JobType> fields = dataList
          .map((data) => JobType.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(fields);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<IncomeType>>> fetchIncomeTypes() async {
    final response = await get('/v1/enums/income-types');

    if (response.status) {
      List<dynamic> dataList = response.data;
      List<IncomeType> fields = dataList
          .map((data) => IncomeType.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(fields);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<List<ApplicationStage>>> fetchApplicationStages() async {
    final response = await get('/v1/enums/application-stages');

    if (response.status) {
      List<dynamic> dataList = response.data;
      List<ApplicationStage> fields = dataList
          .map(
              (data) => ApplicationStage.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(fields);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
