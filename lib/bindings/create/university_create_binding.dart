import 'package:get/get.dart';
import 'package:getx_application/controllers/create/university_create_controller.dart';

class UniversityCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UniversityCreateController>(() => UniversityCreateController());
  }
}