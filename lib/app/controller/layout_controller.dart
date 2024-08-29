import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/ui/android/role_manager.dart';

class LayoutController extends GetxController {
  var pageIndex = 0.obs;
  var userRole = 'Universitas'.obs;
  var isLoading = false.obs;

  List<BottomNavigationBarItem> get getDestinations =>
      RoleManager(userRole.value).destinations;

  List<Widget> get getPages => RoleManager(userRole.value).pages;

  Widget get getCurrentPage => getPages[pageIndex.value];

  void changePage(index) {
    pageIndex.value = index;
  }
}
