import 'package:get/get.dart';
import 'package:getx_application/routes/app_pages.dart';

class SettingController extends GetxController {
  var isLoading = false.obs;

  void fakeSignOut() {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Routes.SIGNIN);
      isLoading.value = false;
    });
  }
}
