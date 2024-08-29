import 'package:get/get.dart';
import 'package:getx_application/app/controller/create/company_create_controller.dart';

class CompanyCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyCreateController>(() => CompanyCreateController());
  }
}
