import 'package:get/get.dart';
import 'package:getx_application/controllers/create/training_create_controller.dart';

class TrainingCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingCreateController>(() => TrainingCreateController());
  }
}
