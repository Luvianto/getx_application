import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_application/chore/handler/api_response.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/models/alumni_in_training/alumni_in_training_model.dart';
import 'package:getx_application/services/alumni_in_trainings_service.dart';

class AlumniInTrainingsController extends GetxController {
  final AlumniInTrainingsService _alumniInTrainingService =
      AlumniInTrainingsService();
  final ScrollController _scrollController = ScrollController();

  var id = '';

  var errorMessage = ''.obs;

  var isLoading = false.obs;
  var alumniInTrainings = <AlumniInTrainingModel>[].obs;
  var isLoadingMore = false.obs;
  var pagination = Pagination().obs;
  int currentPage = 1;
  bool get hasMoreItems =>
      alumniInTrainings.length < pagination.value.totalItems!;

  RxInt postId = 1.obs;

  AlumniInTrainingsController({String? id}) {
    this.id = id ?? '';
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (hasMoreItems && !isLoadingMore.value) {
        fetchAlumniInTrainings(id, isLoadMore: true);
      }
    }
  }

  Future<void> createAlumniInTrainings() async {
    final alumniInTrainingData = {
      "training_post": {
        "id": postId.value,
      },
    };

    final response = await _alumniInTrainingService
        .createAlumniInTrainings(alumniInTrainingData);

    if (response.status) {
      Get.snackbar('Berhasil', 'Anda berhasil mendaftar pada pelatihan ini!',
          snackPosition: SnackPosition.BOTTOM);
      // Get.toNamed('/conversion-histories', id: 10);
    } else {
      print(response.data);
      print(response.error);

      Get.snackbar(
          'Gagal', response.error ?? 'Mohon coba lagi dalam beberapa saat.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> fetchAlumniInTrainings(String id,
      {bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore(true);
    } else {
      isLoading(true);
    }

    final res =
        await _alumniInTrainingService.getAlumniInTrainings(id, params: {
      "limit": "5",
      "page": currentPage.toString(),
      "sort": "created_at",
      "order_by": "desc",
    });
    if (res.isSuccess) {
      if (isLoadMore) {
        alumniInTrainings.addAll(res.data ?? []);
      } else {
        alumniInTrainings.assignAll(res.data ?? []);
      }
      pagination(res.pagination!);
      currentPage++;
    } else {
      Get.snackbar(
        'Gagal',
        res.error ?? 'Gagal mengambil data alumni dalam pelatihan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (isLoadMore) {
      isLoadingMore(false);
    } else {
      isLoading(false);
    }
  }

  printResponse(ServiceResult res) {
    print("Response");
    print("status: ${res.status}");
    print("data: ${res.data}");
    print("error: ${res.error}");
  }

  Future<void> refreshAlumniInTraining() async {
    currentPage = 1;
    alumniInTrainings.clear();
    await fetchAlumniInTrainings(id);
  }

  @override
  void onClose() {
    _scrollController.dispose();
    super.onClose();
  }
}
