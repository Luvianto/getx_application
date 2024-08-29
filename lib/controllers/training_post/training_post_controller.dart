import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/models/training_post/training_post_model.dart';
import 'package:getx_application/services/training_post_service.dart';
import 'package:getx_application/chore/handler/api_response.dart';

class TrainingPostController extends GetxController {
  final TrainingPostService _trainingPostService = TrainingPostService();
  final ScrollController scrollController = ScrollController();

  var isLoading = false.obs;
  var isLoadingDetails = false.obs;
  var isLoadingMore = false.obs;

  var trainingPostData = <TrainingPostModel>[].obs;
  var trainingPostDetails = TrainingPostModel().obs;
  var trainingPostTempEdit = TrainingPostModel().obs;

  var searchKeyword = ''.obs;

  var pagination = Pagination().obs;
  int currentPage = 1;

  TrainingPostController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (hasMoreItems && !isLoadingMore.value) {
        fetchTrainingPost(isLoadMore: true);
      }
    }
  }

  bool get hasMoreItems =>
      trainingPostData.length < pagination.value.totalItems! || false;

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> refreshTrainingPost() async {
    currentPage = 1;
    trainingPostData.clear();
    await fetchTrainingPost();
  }

  Future<void> fetchTrainingPost(
      {bool isLoadMore = false, String keyword = ''}) async {
    isLoading.value = true;
    var res = await _trainingPostService.fetchTrainingPost({
      "limit": "3",
      "page": currentPage.toString(),
      "sort": "created_at",
      "order_by": "desc",
      "keyword": keyword,
    });

    if (res.isSuccess) {
      if (isLoadMore) {
        trainingPostData.addAll(res.data ?? []);
        currentPage++;
      } else {
        trainingPostData.assignAll(res.data ?? []);
        currentPage = 1;
      }
      pagination(res.pagination!);
    } else {
      Get.snackbar(
        'Training Post',
        res.error ?? 'Gagal mengambil data post',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (isLoadMore) {
      isLoadingMore(false);
    } else {
      isLoading(false);
    }
  }

  void fetchTrainingPostDetails(String id) async {
    if (id.isEmpty) {
      Get.snackbar(
        'Training Post',
        'ID Post tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoadingDetails.value = true;
    var res = await _trainingPostService.fetchTrainingPostDetails(id);
    if (res.status) {
      trainingPostDetails.value = res.data!;
    } else {
      Get.snackbar(
        'Training Post',
        res.error ?? 'Gagal mengambil detail post',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoadingDetails.value = false;
  }

  void updateTrainingPost() async {
    final id = trainingPostDetails.value.id!.toString();
    var res = await _trainingPostService.updateTrainingPost(
      id,
      trainingPostTempEdit.value,
    );
    if (res.status) {
      Get.snackbar(
        'Training Post',
        'Berhasil memperbarui post',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed('/details/$id', id: 23);
    } else {
      Get.snackbar(
        'Training Post',
        res.error ?? 'Gagal memperbarui post',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateTrainingPostStatus() async {
    final id = trainingPostDetails.value.id!.toString();
    final status = trainingPostDetails.value.isClosed ?? false;

    var res = await _trainingPostService.updateTrainingPostStatus(id, status);
    if (res.status) {
      Get.snackbar(
        'Training Post',
        'Berhasil memperbarui status post',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed('/details/$id', id: 23);
    } else {
      Get.snackbar(
        'Training Post',
        res.error ?? 'Gagal memperbarui status post',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateTrainingPostLike(int id, bool isLiked) async {
    await _trainingPostService.updateTrainingPostLike(id, isLiked ? 1 : 0);
  }
}
