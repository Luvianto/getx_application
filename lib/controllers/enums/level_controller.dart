import 'package:get/get.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/enum_service.dart';

class LevelController extends GetxController {
  final EnumService _enumService = EnumService();

  var isLoading = false.obs;
  var levels = <LevelEnum>[].obs;

  @override
  void onInit() {
    if (levels.isEmpty) fetchLevels();
    super.onInit();
  }

  void fetchLevels() async {
    isLoading(true);
    var res = await _enumService.fetchLevel();
    if (res.status) {
      levels.assignAll(res.data ?? []);
    } else {
      Get.snackbar(
        'Opsi Level',
        res.error ?? 'Gagal mengambil opsi level',
      );
    }
    isLoading(false);
  }

  String getLevelName(int point) {
    if (levels.isEmpty) return '';
    var level = levels.firstWhere((element) => point >= element.minPoint);
    return level.name;
  }
}
