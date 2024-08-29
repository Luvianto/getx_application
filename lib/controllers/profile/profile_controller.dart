import 'package:get/get.dart';
import 'package:getx_application/common/utils/const.dart';
import 'package:getx_application/controllers/custom_page_controller.dart';
import 'package:getx_application/models/abstract.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/services/auth_service.dart';
import 'package:getx_application/services/file_service.dart';

class ProfileController extends GetxController {
  AuthService authService = AuthService();
  FileService fileService = FileService();
  CustomPageController customPageController = Get.put(CustomPageController());
  var userRole = ''.obs;
  var userResult = Rxn<UserModel>();

  var isLoading = false.obs;
  var message = ''.obs;
  var profileData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    userRole.value = customPageController.userRole.value;
    userResult.value = customPageController.userResult.value;
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;

    if (userRole.value == 'Unknown') {
      await customPageController.isLogin();
      userRole.value = customPageController.userRole.value;
      userResult.value = customPageController.userResult.value;
    }

    var response = await authService.getUserByUuid();
    DetailModel? detail;

    if (userRole.value == rolesMap['ALUMNI']) {
      detail = response.data!.alumniData!;
    } else if (userRole.value == rolesMap['LEMBAGA_PELATIHAN']) {
      detail = response.data!.trainingInstitutionData!;
    } else if (userRole.value == rolesMap['UNIVERSITAS']) {
      detail = response.data!.universityData!;
    } else if (userRole.value == rolesMap['PERUSAHAAN']) {
      detail = response.data!.companyData!;
    } else {
      detail = null;
    }

    profileData.value = {
      'user': response.data,
      'detail': detail as DetailModel,
      'detailUtils': detail.getDetail(),
    };

    isLoading.value = false;
  }
}
