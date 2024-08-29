import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/enum_service.dart';
import 'package:getx_application/services/perusahaan_service.dart';

class RegisterCompanyController extends GetxController {
  var isRegistering = false.obs;

  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  var companyName = ''.obs;
  var selectedType = 0.obs;
  var foundingDate = ''.obs;
  var employeesNumber = 0.obs;
  var earlyWorkingHours = 0.obs;
  var endWorkingHours = 0.obs;

  var companyTypes = <CompanyType>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchCompanyType();
  }

  Future<void> fetchCompanyType() async {
    print('fetching..');
    var response = await EnumService().fetchCompanyType();

    if (response.status) {
      selectedType.value = response.data![0].id;
      companyTypes.value = response.data!;
    } else {
      printResponse(response);
    }
  }

  printResponse(ServiceResult res) {
    print("Response");
    print("status: ${res.status}");
    print("data: ${res.data}");
    print("error: ${res.error}");
  }

  Future<void> pickFoundingDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      foundingDate.value =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      print('Founding date: ${foundingDate.value}');
    }
  }

  Future<void> registerCompany() async {
    isRegistering.value = true;

    final userData = {
      "user": {
        "phone": phoneNumber.value,
        "email": email.value,
        "password": password.value,
      },
      "company_name": companyName.value,
      "company_type": {"id": selectedType.value},
      "founding_date": foundingDate.value,
      "employees_number": employeesNumber.value,
      "early_working_hours": earlyWorkingHours.value,
      "end_working_hours": endWorkingHours.value,
    };

    final response = await PerusahaanService().registerPerusahaan(userData);

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
