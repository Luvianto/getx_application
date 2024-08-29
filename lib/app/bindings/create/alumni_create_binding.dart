import 'package:get/get.dart';
import 'package:getx_application/app/controller/create/alumni_create_controller.dart';

class AlumniCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlumniCreateController>(() => AlumniCreateController());
  }
}
