import 'package:get/get.dart';
import 'package:getx_application/controllers/custom_page_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/routes/app_pages.dart';
import 'package:getx_application/services/auth_service.dart';

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

  final _userRole = RoleEnum(id: '', name: '').obs;
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

class SignInController extends GetxController {
  AuthService authService = AuthService();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var email = ''.obs;
  void setEmail(String? value) => email.value = value ?? '';

  var password = ''.obs;
  void setPassword(String? value) => password.value = value ?? '';

  var fcmToken = ''.obs;
  var message = ''.obs;

  void signIn() async {
    try {
      isLoading.value = true;
      fcmToken.value = await authService.getFcmToken();

      var userData = {
        "email": email.value,
        "password": password.value,
        "fcm_token": fcmToken.value,
      };

      var response = await authService.signIn(userData);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.offAllNamed('/layout');
        Get.snackbar(
          'Login',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during login.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void signOut() async {
    CustomPageController customPageController =
        Get.find<CustomPageController>();

    isLoading.value = true;
    fcmToken.value = await authService.getFcmToken();

    var body = {
      "fcm_token": fcmToken.value,
    };

    var response = await authService.signOut(body);
    if (!response.status) {
      message.value = response.error!;
      Get.snackbar(
        '${message.value}!',
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      customPageController.changePageIndex(0);
      Get.offAllNamed('/signin');
      Get.snackbar(
        'Logout',
        'Logout successful!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }
}
