import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
