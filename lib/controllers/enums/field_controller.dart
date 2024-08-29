import 'package:get/get.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/enum_service.dart';

class FieldController extends GetxController {
  final EnumService _enumService = EnumService();

  var isLoading = false.obs;
  var fields = <FieldEnum>[].obs;

  void fetchFields() async {
    isLoading(true);
    var res = await _enumService.fetchFields();
    if (res.status) {
      fields.assignAll(res.data!);
    } else {
      Get.snackbar(
        'Opsi Bidang',
        res.error ?? 'Gagal mengambil data bidang',
      );
    }
    isLoading(false);
  }
}
