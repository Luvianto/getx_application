import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/role_based_navigation_manager.dart';
import 'package:getx_application/services/auth_service.dart';

class CustomPageController extends GetxController {
  var pageIndex = 0.obs;
  var userRole = "Unknown".obs;
  var isLoading = true.obs;
  var userImageUrl = "".obs;
  var userResult = Rxn<UserModel>();

  AuthService authService = AuthService();

  RoleBasedNavigationManager get navigationManager =>
      RoleBasedNavigationManager(userRole.value);

  List<BottomNavigationBarItem> get finalDestinations =>
      navigationManager.destinations;

  List<Widget> get finalPages => navigationManager.pages;

  Widget get currentPage => finalPages[pageIndex.value];

  void changePageIndex(int index) {
    pageIndex.value = index;
  }

  Future<void> isLogin() async {
    var result = await authService.isLogin();
    if (result.status && result.data!.isAdmin == false) {
      var data = result.data;
      RoleEnum role = data!.role;
      userRole.value = role.name;
      var userResultResponse = await authService.getUserByUuid();
      userResult.value = userResultResponse.data;
      userImageUrl.value = userResult.value!.imageUrl!;
      isLoading.value = false;
    } else {
      Get.toNamed('/signin', id: 1);
    }
  }
}
