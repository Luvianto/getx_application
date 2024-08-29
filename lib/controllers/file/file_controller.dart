import 'package:get/get.dart';
import 'package:getx_application/services/file_service.dart';

class FileController extends GetxController {
  FileService fileService = FileService();

  var isLoading = false.obs;

  Future<bool> isValidFile(String url) async {
    if (url.isEmpty) {
      return false;
    }
    var isValid = await fileService.validateFileById(url);
    if (isValid) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> uploadFile(Map<String, dynamic> body) async {
    isLoading.value = true;

    final res = await fileService.uploadFile(body);
    if (res.status) {
      Get.snackbar(
        "File Upload",
        "File uploaded successfully",
      );
      isLoading.value = false;

      return res.data ?? '';
    } else {
      Get.snackbar(
        "File Upload Error",
        "Error uploading file",
      );
      isLoading.value = false;
      return '';
    }
  }

  Future<void> deleteFile(String urlId) async {
    if (urlId.isEmpty) {
      return;
    }
    await fileService.deleteFile(urlId);
  }
}
