import 'package:get/get.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/models/pddikti/university_model.dart';
import 'package:getx_application/services/alumni_service.dart';
import 'package:getx_application/services/pddikti_service.dart';
import 'package:getx_application/services/universitas_service.dart';

class RegisterUniversityController extends GetxController {
  var universityName = ''.obs;
  var universityId = ''.obs;

  var universities = <PddiktiUniversityModel>[].obs;
  var isLoadingUniversities = false.obs;

  var isSelectingUniversity = false.obs;

  var isRegistering = false.obs;

  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  AlumniService alumniService = AlumniService();
  PddiktiService pddiktiService = PddiktiService();

  @override
  void onInit() {
    super.onInit();

    debounce(universityName, (_) {
      if (!isSelectingUniversity.value) {
        fetchUniversities();
      }
    }, time: const Duration(milliseconds: 1000));
  }

  printResponse(ServiceResult res) {
    print("Response");
    print("status: ${res.status}");
    print("data: ${res.data}");
    print("error: ${res.error}");
  }

  Future<void> fetchUniversities() async {
    if (universityName.value.isEmpty) {
      universities.clear();
      return;
    }

    isLoadingUniversities.value = true;
    var response =
        await pddiktiService.findUniversitiesByName(universityName.value);

    if (response.status) {
      universities.value = response.data!;
    } else {
      universities.clear();
      universityId.value = '';
      printResponse(response);
    }
    isLoadingUniversities.value = false;
  }

  Future<void> registerUniversity() async {
    isRegistering.value = true;

    final userData = {
      "user": {
        "phone": phoneNumber.value,
        "email": email.value,
        "password": password.value,
      },
      "pddikti_university_id": universityId.value,
      "university_name": universityName.value,
    };

    final response = await UniversitasService().registerUniversitas(userData);

    if (response.status) {
      Get.snackbar('Berhasil', 'Akun akan diverifikasi oleh Admin segera!',
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed('/signin', id: 1);
    } else {
      Get.snackbar('Gagal', 'Mohon coba lagi dalam beberapa saat.',
          snackPosition: SnackPosition.BOTTOM);
      printResponse(response);
    }

    isRegistering.value = false;
  }
}
