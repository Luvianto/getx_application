import 'package:get/get.dart';
import 'package:getx_application/app/data/models/enums.dart';
import 'package:getx_application/app/routes/app_pages.dart';
import 'package:getx_application/app/services/auth_service.dart';

class SigninController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    isLogin();
  }

  var email = ''.obs;
  var password = ''.obs;

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final _userRole = Role().obs;
  get userRole => _userRole.value;
  set userRole(value) => _userRole.value = value;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void fakeSignIn() {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      Get.offNamed(Routes.LAYOUT);
      isLoading.value = false;
    });
  }

  void isLogin() async {
    var res = await AuthService().isLogin();

    if (res.status) {
      userRole(res.data!.role.name);

      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(Routes.LAYOUT);
        Get.snackbar(
          'Selamat datang kembali!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    }
  }
}
