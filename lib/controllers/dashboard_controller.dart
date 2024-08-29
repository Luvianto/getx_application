import 'package:get/get.dart';
import 'package:getx_application/models/dashboard/alumni_dashboard_model.dart';
import 'package:getx_application/models/dashboard/company_dashboard_model.dart';
import 'package:getx_application/models/dashboard/university_dashboard_model.dart';
import 'package:getx_application/models/dashboard/training_dashboard_model.dart';
import 'package:getx_application/services/dashboard_service.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;

  DashboardService dashboardService = DashboardService();

  var alumniDashboardData = AlumniDashboardModel().obs;
  var universityDashboardData = UniversityDashboardModel().obs;
  var companyDashboardData = CompanyDashboardModel().obs;
  var trainingDashboardData = TrainingDashboardModel().obs;

  void fetchAlumniDashboard() async {
    isLoading.value = true;
    var res = await dashboardService.fetchAlumniDashboard();
    if (res.status) {
      alumniDashboardData.value = res.data!;
    } else {
      print(res.error);
    }
    isLoading.value = false;
  }

  void fetchUniversiDashboard() async {
    isLoading.value = true;
    var res = await dashboardService.fetchUniversityDashboard();
    if (res.status) {
      universityDashboardData.value = res.data!;
    } else {
      print(res.error);
    }
    isLoading.value = false;
  }

  void fetchCompanyDashboard() async {
    isLoading.value = true;
    var res = await dashboardService.fetchCompanyDashboard();
    if (res.status) {
      companyDashboardData.value = res.data!;
    } else {
      print(res.error);
    }
    isLoading.value = false;
  }

  void fetchTrainingDashboard() async {
    isLoading.value = true;
    var res = await dashboardService.fetchTrainingDashboard();
    if (res.status) {
      trainingDashboardData.value = res.data!;
    } else {
      print(res.error);
    }
    isLoading.value = false;
  }
}
