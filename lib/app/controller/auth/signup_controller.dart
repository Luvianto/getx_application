import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/routes/app_pages.dart';

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
