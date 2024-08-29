import 'package:get/get.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/models/application/application_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/application_service.dart';
import 'package:getx_application/services/enum_service.dart';

class ApplicationController extends GetxController {
  final ApplicationService _applicationService = ApplicationService();

  var applications = <ApplicationModel>[].obs;
  var applicationDetails = ApplicationModel().obs;

  var isLoading = false.obs;
  var isLoadingDetails = false.obs;

  var selectedField = ''.obs;
  var fieldName = ''.obs;

  var fieldEnum = [ApplicationStage(id: 1, name: '')].obs;

  var errorMessage = ''.obs;

  Future<void> fetchApplications() async {
    isLoading(true);
    final result = await _applicationService.fetchApplications(params: {
      "sort": "created_at",
      "order_by": "desc",
    });

    if (result.isSuccess) {
      printResponse(result);

      applications.assignAll(result.data ?? []);
    } else {
      errorMessage(result.error);
    }
    isLoading(false);
  }

  void fetchApplicationByID(String id) async {
    if (id.isEmpty) {
      Get.snackbar(
        'Application Details',
        'ID Application tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoadingDetails.value = true;
    var res = await _applicationService.fetchApplicationsByID(id);
    if (res.status) {
      applicationDetails.value = res.data!;
    } else {
      Get.snackbar(
        'Applications by ID',
        res.error ?? 'Gagal mengambil detail lamaran',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoadingDetails.value = false;
  }

  void fetchApplicationByVacancy(String id) async {
    if (id.isEmpty) {
      Get.snackbar(
        'Vacancy Application',
        'ID Application by Vacancy tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoadingDetails.value = true;
    var res = await _applicationService.fetchApplicationsByVacancyID(id);
    if (res.status) {
      applications.assignAll(res.data ?? []);
    } else {
      Get.snackbar(
        'Applications by Vacancy ID',
        res.error ?? 'Gagal mengambil detail lamaran',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoadingDetails.value = false;
  }

  void fetchApplicationStages() async {
    var res = await EnumService().fetchApplicationStages();
    if (res.status) {
      var data = res.data;

      selectedField.value = data![0].id.toString();
      fieldEnum.value = res.data!;
    } else {
      Get.snackbar('Fetch Bidang Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  Future<void> updateApplicationStatus(String id, String vacancyID) async {
    final statusData = {
      "status": int.parse(selectedField.value),
    };

    final response =
        await _applicationService.updateApplicationStatus(statusData, id);

    if (response.status) {
      fetchApplicationByVacancy(vacancyID);
      Get.snackbar('Berhasil', 'Status Lamaran berhasil di update!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Gagal', 'Mohon coba lagi dalam beberapa saat.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  printResponse(ServiceResult res) {
    print("Response");
    print("status: ${res.status}");
    print("data: ${res.data}");
    print("error: ${res.error}");
  }
}
