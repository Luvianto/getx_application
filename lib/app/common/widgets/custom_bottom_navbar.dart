import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class CustomBottomNavbar extends GetView<LayoutController> {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LayoutController>();
    return Obx(() => BottomNavigationBar(
          selectedItemColor: const Color(0xff25324A),
          unselectedItemColor: const Color(0xff25324A),
          currentIndex: controller.pageIndex.value,
          onTap: controller.changePage,
          items: controller.getDestinations,
        ));
  }
}
