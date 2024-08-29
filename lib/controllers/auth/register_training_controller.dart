import 'package:get/get.dart';
import 'package:getx_application/services/lembaga_pelatihan_service.dart';

class RegisterTrainingController extends GetxController {
  var isLoading = false.obs;
  var institutionName = ''.obs;

  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  Future<void> registerLembagaPelatihan() async {
    isLoading.value = true;

    final userData = {
      "user": {
        "phone": phoneNumber.value,
        "email": email.value,
        "password": password.value,
      },
      "institution_name": institutionName.value,
    };

    final response =
        await LembagaPelatihanService().registerLembagaPelatihan(userData);

    if (response.status) {
      Get.snackbar('Berhasil', 'Akun akan diverifikasi oleh Admin segera!',
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed('/signin', id: 1);
    } else {
      Get.snackbar('Gagal', 'Mohon coba lagi dalam beberapa saat.',
          snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
  }
}
