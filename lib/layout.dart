import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/signin_controller.dart';
import 'package:getx_application/controllers/custom_page_controller.dart';
import 'package:getx_application/widgets/custom_appbar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final CustomPageController customPageController =
      Get.put(CustomPageController());
  final signInController = Get.put(SignInController());

  @override
  void initState() {
    customPageController.isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (customPageController.isLoading.value ||
          signInController.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else {
        return Scaffold(
          appBar: CustomAppBar(
            subtitle: "as ${customPageController.userRole}",
            imageUrl: customPageController.userImageUrl.value,
          ),
          body: customPageController.currentPage,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: customPageController.pageIndex.value,
            onTap: customPageController.changePageIndex,
            items: customPageController.finalDestinations,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            enableFeedback: false,
          ),
        );
      }
    });
  }
}
