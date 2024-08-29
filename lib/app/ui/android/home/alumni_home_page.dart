import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';
import 'package:getx_application/app/routes/app_pages.dart';

class AlumniHomePage extends GetView<LayoutController> {
  const AlumniHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Alumni Home Screen'),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.VACANCY);
              },
              child: const Text('Vacancy'))
        ],
      ),
    );
  }
}
