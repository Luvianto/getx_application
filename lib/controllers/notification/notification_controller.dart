import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/chore/handler/api_response.dart';
import 'package:getx_application/models/notification/notification_model.dart';
import 'package:getx_application/services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  final ScrollController scrollController = ScrollController();

  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var errorMessage = ''.obs;
  var pagination = Pagination().obs;
  int currentPage = 1;

  NotificationController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (hasMoreItems && !isLoadingMore.value) {
        fetchNotifications(isLoadMore: true);
      }
    }
  }

  Future<void> fetchNotifications({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore(true);
    } else {
      isLoading(true);
    }

    final result = await _notificationService.getNotifications(params: {
      "limit": "10",
      "page": currentPage.toString(),
      "sort": "created_at",
      "order_by": "desc",
    });

    if (result.isSuccess) {
      if (isLoadMore) {
        notifications.addAll(result.data ?? []);
      } else {
        notifications.assignAll(result.data ?? []);
      }
      pagination(result.pagination!);
      currentPage++;
    } else {
      errorMessage(result.error);
    }

    if (isLoadMore) {
      isLoadingMore(false);
    } else {
      isLoading(false);
    }
  }

  bool get hasMoreItems => notifications.length < pagination.value.totalItems!;

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
