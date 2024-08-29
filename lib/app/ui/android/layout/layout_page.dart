import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/common/widgets/custom_appbar.dart';
import 'package:getx_application/app/common/widgets/custom_bottom_navbar.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class LayoutPage extends GetView<LayoutController> {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const CustomAppBar(),
            body: controller.getCurrentPage,
            bottomNavigationBar: const CustomBottomNavbar(),
          ));
  }
}
