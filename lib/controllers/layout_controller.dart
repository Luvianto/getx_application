import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/role_based_navigation_manager.dart';

class LayoutController extends GetxController {
  var pageIndex = 0.obs;
  var userRole = 'Universitas'.obs;
  var isLoading = false.obs;

  List<BottomNavigationBarItem> get getDestinations =>
      RoleBasedNavigationManager(userRole.value).destinations;

  List<Widget> get getPages => RoleBasedNavigationManager(userRole.value).pages;

  Widget get getCurrentPage => getPages[pageIndex.value];

  void changePage(index) {
    pageIndex.value = index;
  }
}
