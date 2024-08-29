import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/dashboard/alumni_dashboard_model.dart';
import 'package:getx_application/models/dashboard/company_dashboard_model.dart';
import 'package:getx_application/models/dashboard/training_dashboard_model.dart';
import 'package:getx_application/models/dashboard/university_dashboard_model.dart';

class DashboardService extends ApiInstance {
  Future<ServiceResult<AlumniDashboardModel>> fetchAlumniDashboard() async {
    final response =
        await get('/v1/dashboard/alumni', queryParams: {'month': 'full'});

    if (response.status) {
      return ServiceResult.success(
          AlumniDashboardModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<UniversityDashboardModel>>
      fetchUniversityDashboard() async {
    final response =
        await get('/v1/dashboard/university', queryParams: {'month': 'full'});

    if (response.status) {
      return ServiceResult.success(
          UniversityDashboardModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<CompanyDashboardModel>> fetchCompanyDashboard() async {
    final response =
        await get('/v1/dashboard/company', queryParams: {'month': 'full'});

    if (response.status) {
      return ServiceResult.success(
          CompanyDashboardModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<TrainingDashboardModel>> fetchTrainingDashboard() async {
    final response = await get('/v1/dashboard/training-institutions',
        queryParams: {'month': 'full'});

    if (response.status) {
      return ServiceResult.success(
          TrainingDashboardModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
