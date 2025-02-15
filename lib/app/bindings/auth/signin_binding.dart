import 'package:get/get.dart';
import 'package:getx_application/app/controller/auth/signin_controller.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController());
  }
}
