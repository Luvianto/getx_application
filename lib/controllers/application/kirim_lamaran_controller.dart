import 'package:get/get.dart';
import 'package:getx_application/services/application_service.dart';
import 'package:getx_application/services/file_service.dart';

class KirimLamaranController extends GetxController {
  var fileUrl = ''.obs;
  var isLoading = false.obs;
  var message = ''.obs;
  var selectedVacancyId = 0.obs;

  Future<void> postApplication(int id) async {
    var applicationData = {
      "vacancy": {"id": id},
      "resume_url": fileUrl.value
    };

    var res = await ApplicationService().postApplication(applicationData);
    if (res.status) {
      Get.snackbar(
        'Berhasil',
        'Lowongan Anda sudah terkirim',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      message.value = res.error!;
      Get.snackbar(
        '${message.value}!',
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> uploadFile(Map<String, dynamic> body) async {
    try {
      isLoading.value = true;

      final response = await FileService().uploadFile(body);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        message.value = 'File uploaded successfully';
        Get.snackbar(
          'Success',
          message.value,
          snackPosition: SnackPosition.BOTTOM,
        );
        fileUrl.value = response.data!;
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFile(String urlId) async {
    if (urlId.isEmpty) {
      return;
    }
    try {
      isLoading.value = true;

      final response = await FileService().deleteFile(urlId);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        message.value = 'File deleted successfully';
        fileUrl.value = '';
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
