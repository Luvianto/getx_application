import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/chore/handler/api_response.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';
import 'package:getx_application/services/vacancy_service.dart';

class VacancyController extends GetxController {
  var id = 0;

  VacancyController({int? id}) {
    this.id = id ?? 0;
    _scrollController.addListener(_onScroll);
  }

  final ScrollController _scrollController = ScrollController();
  final VacancyService _vacancyService = VacancyService();

  var errorMessage = ''.obs;

  var isLoading = false.obs;
  var isLoadingDetails = false.obs;
  var isLoadingMore = false.obs;

  var fetchingVacancy = true.obs;

  var vacancies = <VacancyModel>[].obs;
  var vacancy = VacancyModel().obs;

  var searchKeyword = ''.obs;

  var pagination = Pagination().obs;
  int currentPage = 1;
  bool get hasMoreItems =>
      vacancies.length < (pagination.value.totalItems ?? 0);

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (hasMoreItems && !isLoadingMore.value) {
        fetchVacancies(isLoadMore: true);
      }
    }
  }

  Future<void> fetchVacancies(
      {bool isLoadMore = false, String keyword = ''}) async {
    // isLoading.value = true;

    if (isLoadMore) {
      isLoadingMore(true);
    } else {
      isLoading(true);
    }

    final res = await _vacancyService.fetchVacancies(params: {
      "limit": "5",
      "page": currentPage.toString(),
      "sort": "created_at",
      "order_by": "desc",
      "keyword": keyword
    });

    if (res.isSuccess) {
      if (isLoadMore) {
        vacancies.addAll(res.data ?? []);
        currentPage++;
      } else {
        vacancies.assignAll(res.data ?? []);
        currentPage = 1;
      }
      pagination(res.pagination!);
    } else {
      Get.snackbar(
        'Gagal',
        res.error ?? 'Gagal mengambil data lowongan pekerjaan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (isLoadMore) {
      isLoadingMore(false);
    } else {
      isLoading(false);
    }
  }

  void fetchVacancy(int id) async {
    if (id == 0) {
      Get.snackbar(
        'Lowongan Pekerjaan',
        'ID Lowongan tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoadingDetails.value = true;

    final res = await _vacancyService.fetchVacancy(id);
    if (res.status) {
      vacancy.value = res.data!;
    } else {
      Get.snackbar(
        'Lowongan Pekerjaan',
        res.error ?? 'Gagal mengambil detail lowongan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoadingDetails.value = false;
  }

  Future<void> refreshAlumniInTraining() async {
    currentPage = 1;
    vacancies.clear();
    await fetchVacancies();
  }

  void updateVacancyLike(int id, bool isLiked) async {
    await _vacancyService.updateVacancyLike(id, isLiked ? 1 : 0);
  }
}
