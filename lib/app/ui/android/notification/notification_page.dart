import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';
import 'package:getx_application/app/routes/app_pages.dart';

class NotificationPage extends GetView<LayoutController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Notification Page'),
          ElevatedButton(
              onPressed: () {
                controller.pageIndex.value = 0;
              },
              child: Text('Dahboard')),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.VACANCY);
              },
              child: Text('Vacancy')),
        ],
      ),
    );
  }
}
