import 'package:get/get.dart';
import 'package:getx_application/services/auth_service.dart';

class ResetPasswordController extends GetxController {
  var email = ''.obs;
  var isLoading = false.obs;
  var isEmailSent = false.obs;

  AuthService authService = AuthService();

  void sendResetPasswordRequest() async {
    isLoading.value = true;
    var res = await authService.sendResetPasswordRequest(email.value);

    if (res.status) {
      Get.snackbar(
        "Email Terkirim",
        "Silakan cek email Anda untuk mengatur ulang kata sandi",
        snackPosition: SnackPosition.BOTTOM,
      );
      isEmailSent.value = true;
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar",
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }
}
