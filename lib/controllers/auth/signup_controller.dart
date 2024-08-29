import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_application/routes/app_pages.dart';
import 'package:getx_application/services/auth_service.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var email = ''.obs;
  void setEmail(String? value) => email.value = value ?? '';

  var phone = ''.obs;
  void setPhone(String? value) => phone.value = value ?? '';

  var password = ''.obs;
  void setPassword(String value) => password.value = value;

  var confirmPassword = ''.obs;
  void setConfirmPassword(String value) => confirmPassword.value = value;

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isConfirmPasswordVisible = false.obs;
  void toogleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  var isLoading = false.obs;

  void fakeCheckEmail() async {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed(Routes.SELECTROLE);
    });
    isLoading.value = false;
  }
}

class SignUpController extends GetxController {
  var email = ''.obs;
  void setEmail(String? value) => email.value = value ?? '';

  var phoneNumber = ''.obs;
  void setPhoneNumber(String? value) => phoneNumber.value = value ?? '';

  var password = ''.obs;
  void setPassword(String? value) => password.value = value ?? '';

  var confirmPassword = ''.obs;
  void setConfirmPassword(String? value) => confirmPassword.value = value ?? '';

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  var isLoading = false.obs;

  AuthService authService = AuthService();

  void toogleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toSelectRole(bool isExist) {
    if (isExist) {
      Get.snackbar(
          "Email telah digunakan", "Gunakan email lain untuk mendaftar",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.snackbar('Daftar', 'Pilih role Anda!',
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('/role-selection', id: 1);
      });
    }
    isLoading.value = false;
  }

  void checkEmail() async {
    bool isExist = false;
    isLoading.value = true;
    var res = await authService.checkEmail(email.value);

    if (res.status) {
      isExist = res.data["isExist"];
      toSelectRole(isExist);
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Silakan coba ulang dalam beberapa saat",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
