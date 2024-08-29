import 'package:get/get.dart';
import 'package:getx_application/models/vacancy/vacancy_comment_model.dart';
import 'package:getx_application/services/vacancy_service.dart';

class VacancyCommentController extends GetxController {
  VacancyService vacancyService = VacancyService();

  var isLoading = false.obs;
  var commentData = <VacancyCommentModel>[].obs;

  var postId = ''.obs;
  var commentDescription = ''.obs;

  void fetchVacancyComments(String id) async {
    isLoading.value = true;
    var res = await vacancyService.fetchVacancyComments(id);

    if (res.status) {
      commentData.value = res.data!;
    } else {
      Get.snackbar(
        'Vacancy Comment',
        res.error!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<bool> postVacancyComments() async {
    var body = {
      "comment": commentDescription.value,
    };

    var res = await VacancyService().createVacancyComment(postId.value, body);

    if (res.status) {
      fetchVacancyComments(postId.value);
      Get.snackbar('Berhasil', 'Komentar berhasil dikirim');
    } else {
      Get.snackbar('Kirim Komentar Gagal', 'Coba lagi dalam beberapa saat');
    }

    return res.status;
  }
}
