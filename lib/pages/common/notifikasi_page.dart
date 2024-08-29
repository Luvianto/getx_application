import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/consts/notif_type.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/notification/notification_controller.dart';
import 'package:getx_application/models/notification/notification_model.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/infinite_scroll.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  final NotificationController controller = Get.put(NotificationController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.fetchNotifications();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreItems && !controller.isLoadingMore.value) {
          controller.fetchNotifications(isLoadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshNotifications() async {
    controller.currentPage = 1;
    controller.notifications.clear();
    await controller.fetchNotifications();
  }

// Temporary disabled, due to bad routing
  void _onTap(String type, String itemID) {
    switch (type) {
      case NotifType.warning:
        break;
      case NotifType.info:
        break;
      case NotifType.vacancy:
        break;
      case NotifType.trainingPost:
        break;
      case NotifType.vacancyJourney:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            Text(
              'Notifikasi',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshNotifications,
                child: InfiniteScrollList<NotificationModel>(
                  scrollController: _scrollController,
                  items: controller.notifications,
                  hasMoreItems: () => controller.hasMoreItems,
                  isLoading: controller.isLoading,
                  isLoadingMore: controller.isLoadingMore,
                  fetchMoreItems: () =>
                      controller.fetchNotifications(isLoadMore: true),
                  itemBuilder: (context, notif) {
                    return GestureDetector(
                      onTap: () => _onTap(notif.type, notif.itemID),
                      child: CustomContainer(
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    child: handlePictureWidget(
                                      imageUrl: notif.thumbnailURL,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      notif.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                notif.body,
                                style: Theme.of(context).textTheme.bodyMedium,
                                softWrap: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    formatTimestamp(notif.createdAt),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  bottomPadding: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
