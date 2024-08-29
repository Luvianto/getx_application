import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx_application/common/utils/const.dart';
import 'package:getx_application/controllers/profile/profile_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/models/wilayah/wilayah_model.dart';
import 'package:getx_application/services/alumni_service.dart';
import 'package:getx_application/services/auth_service.dart';
import 'package:getx_application/services/enum_service.dart';
import 'package:getx_application/services/file_service.dart';
import 'package:getx_application/services/lembaga_pelatihan_service.dart';
import 'package:getx_application/services/perusahaan_service.dart';
import 'package:getx_application/services/universitas_service.dart';
import 'package:getx_application/services/wilayah_service.dart';

class ProfileEditController extends GetxController {
  EnumService enumService = EnumService();
  WilayahService wilayahService = WilayahService();

  AuthService authService = AuthService();
  AlumniService alumniService = AlumniService();
  LembagaPelatihanService lembagaPelatihanService = LembagaPelatihanService();
  PerusahaanService perusahaanService = PerusahaanService();
  UniversitasService universitasService = UniversitasService();

  FileService fileService = FileService();

  var isEditLoading = false.obs;
  var message = ''.obs;

  var fields = <FieldEnum>[].obs;
  var provinces = <WilayahModel>[].obs;
  var regencies = <WilayahModel>[].obs;
  var districts = <WilayahModel>[].obs;

  var updatedImageUrl = ''.obs;
  final profileController = Get.put(ProfileController());

  @override
  void onInit() {
    fetchFields();
    fetchProvinces();
    super.onInit();
  }

  Future<void> fetchFields() async {
    try {
      isEditLoading.value = true;

      final response = await enumService.fetchFields();
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        fields.value = response.data!;
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isEditLoading.value = false;
    }
  }

  Future<void> fetchProvinces() async {
    try {
      isEditLoading.value = true;

      final response = await wilayahService.fetchAllProvinces();
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        provinces.value = response.data!;
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isEditLoading.value = false;
    }
  }

  Future<void> fetchRegenciesByProvince(String provinceCode) async {
    try {
      isEditLoading.value = true;

      final response =
          await wilayahService.fetchRegenciesByProvince(provinceCode);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        regencies.value = response.data!;
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isEditLoading.value = false;
    }
  }

  Future<void> fetchDistrictsByCity(String cityCode) async {
    try {
      isEditLoading.value = true;

      final response = await wilayahService.fetchDistrictsByCity(cityCode);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        districts.value = response.data!;
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isEditLoading.value = false;
    }
  }

  Future<void> updateProfile(Object body) async {
    isEditLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');

    var response;
    if (role == rolesMap['ALUMNI']) {
      response = await alumniService.updateAlumni(body);
    } else if (role == rolesMap['LEMBAGA_PELATIHAN']) {
      response = await lembagaPelatihanService.updateLembagaPelatihan(body);
    } else if (role == rolesMap['UNIVERSITAS']) {
      response = await universitasService.updateUniversitas(body);
    } else if (role == rolesMap['PERUSAHAAN']) {
      response = await perusahaanService.updatePerusahaan(body);
    }

    if (!response.status) {
      message.value = response.error!;
      Get.snackbar(
        '${message.value}!',
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      message.value = 'Profile updated successfully';
      Get.back(
          id: profileController.profileData.value!['detailUtils']['editId']);
      Get.snackbar(
        'Success',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
      profileController.loadProfile();
    }

    isEditLoading.value = false;
  }

  Future<void> deleteFile(String urlId) async {
    if (urlId.isEmpty) {
      return;
    }
    try {
      isEditLoading.value = true;

      final response = await fileService.deleteFile(urlId);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        message.value = 'File deleted successfully';
        updatedImageUrl.value = '';
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isEditLoading.value = false;
    }
  }

  Future<void> uploadFile(Map<String, dynamic> body) async {
    try {
      isEditLoading.value = true;

      final response = await fileService.uploadFile(body);
      if (!response.status) {
        message.value = response.error!;
        Get.snackbar(
          '${message.value}!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        message.value = 'File uploaded successfully';
        Get.snackbar(
          'Success',
          message.value,
          snackPosition: SnackPosition.BOTTOM,
        );
        updatedImageUrl.value = response.data!;
      }
    } catch (e) {
      message.value = 'An error occurred';
      Get.snackbar(
        'Error',
        message.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isEditLoading.value = false;
    }
  }
}
