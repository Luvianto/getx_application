import 'package:get/get.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/enum_service.dart';
import 'package:getx_application/services/lembaga_pelatihan_service.dart';

class TambahPostController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  var selectedField = ''.obs;
  var fileName = ''.obs;
  var point = 0.obs;
  var isTraining = true.obs;

  var fieldEnum = [FieldEnum(id: '', name: '')].obs;

  void fetchFields() async {
    var res = await EnumService().fetchFields();
    if (res.status) {
      var data = res.data;
      print('${data![0].id}${data[0].name}');
      selectedField.value = data[0].id;
      fieldEnum.value = res.data!;
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  Future<bool> postTraining() async {
    var body = {
      "title": title.value,
      "thumbnail_url": fileName.value,
      "description": description.value,
      "point": point.value,
      "is_training": isTraining.value,
      "field": {'id': '66b6e810c44ac63abe9e2627'},
    };
    var res = await LembagaPelatihanService().postTraining(body);
    if (res.status) {
      var data = res.data as Map<String, dynamic>;
      Get.snackbar('Post berhasil', '${data['title']}!');
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
    return res.status;
  }
}
