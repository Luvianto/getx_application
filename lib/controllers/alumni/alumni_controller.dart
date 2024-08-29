import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/chore/handler/api_response.dart';
import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/services/alumni_service.dart';

class AlumniController extends GetxController {
  final AlumniService _alumniService = AlumniService();
  final ScrollController scrollController = ScrollController();

  var isLoading = false.obs;
  var isLoadingDetails = false.obs;
  var isLoadingMore = false.obs;

  var alumniData = <AlumniModel>[].obs;
  var alumniDetails = AlumniModel().obs;

  var searchKeyword = ''.obs;

  var pagination = Pagination().obs;
  int currentPage = 1;

  AlumniController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (hasMoreItems && !isLoadingMore.value) {
        fetchAlumni(isLoadMore: true);
      }
    }
  }

  bool get hasMoreItems {
    final totalItems = pagination.value.totalItems;
    if (totalItems != null) {
      return alumniData.length < totalItems;
    }
    return false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> refreshAlumnis() async {
    currentPage = 1;
    alumniData.clear();
    await fetchAlumni();
  }

  Future<void> fetchAlumni(
      {bool isLoadMore = false, String keyword = ''}) async {
    isLoading.value = true;
    var res = await _alumniService.getAlumnis({
      "limit": "3",
      "page": currentPage.toString(),
      "sort": "created_at",
      "order_by": "desc",
      "name": keyword,
    });

    if (res.isSuccess) {
      // List<dynamic> dynamicList = res.data ?? [];

      if (isLoadMore) {
        alumniData.addAll(res.data ?? []);

        currentPage++;
      } else {
        alumniData.assignAll(res.data ?? []);

        currentPage = 1;
      }

      pagination(res.pagination!);
    } else {
      Get.snackbar(
        'Alumni',
        res.error ?? 'Gagal mengambil data alumni',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (isLoadMore) {
      isLoadingMore(false);
    } else {
      isLoading(false);
    }
  }

  void fetchAlumniDetails(String id) async {
    if (id.isEmpty) {
      Get.snackbar(
        'Alumni',
        'ID Alumni tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoadingDetails.value = true;
    var res = await _alumniService.getAlumniById(id);

    if (res.status) {
      alumniDetails.value = res.data!;
      print(res.data);
    } else {
      Get.snackbar(
        'Alumni Detail',
        res.error ?? 'Gagal mengambil detail alumni',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoadingDetails.value = false;
  }
}
