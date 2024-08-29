import 'package:get/get.dart';
import 'package:getx_application/models/training_post/training_post_comment_model.dart';
import 'package:getx_application/services/training_post_service.dart';

class TrainingPostCommentController extends GetxController {
  TrainingPostService trainingPostService = TrainingPostService();

  var isLoading = false.obs;
  var commentData = <TrainingPostCommentModel>[].obs;

  var postId = ''.obs;
  var commentDescription = ''.obs;

  void fetchTrainingPost(String id) async {
    isLoading.value = true;
    var res = await trainingPostService.fetchTrainingPostComments(id);
    if (res.status) {
      commentData.value = res.data!;
    } else {
      Get.snackbar(
        'Training Post Comment',
        res.error!,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<bool> postTrainingComments() async {
    var body = {
      "comment": commentDescription.value,
    };

    var res = await TrainingPostService()
        .createTrainingPostComment(postId.value, body);

    if (res.status) {
      fetchTrainingPost(postId.value);
      Get.snackbar('Berhasil', 'Komentar berhasil dikirim');
    } else {
      Get.snackbar('Kirim Komentar Gagal', 'Coba lagi dalam beberapa saat');
    }

    return res.status;
  }
}
