import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/models/pddikti/student_model.dart';
import 'package:getx_application/models/pddikti/university_model.dart';
import 'package:getx_application/services/alumni_service.dart';
import 'package:getx_application/services/pddikti_service.dart';

class RegisterAlumniController extends GetxController {
  var universityName = ''.obs;
  var universityId = ''.obs;

  var studentNim = ''.obs;
  var studentName = ''.obs;
  String studentMajor = '';
  String studentId = '';

  var universities = <PddiktiUniversityModel>[].obs;
  var isLoadingUniversities = false.obs;

  var students = <PddiktiStudentModel>[].obs;

  var isLoadingStudents = false.obs;

  var isSelectingUniversity = false.obs;
  var isSelectingStudent = false.obs;

  var isRegistering = false.obs;
  var studentMessage = ''.obs;

  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var gpa = 0.0.obs;
  var graduationDate = ''.obs;

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

    debounce(studentNim, (_) {
      if (!isSelectingStudent.value) {
        fetchStudents();
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

  Future<void> pickGraduationDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      graduationDate.value =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}";
    }
  }

  Future<void> fetchStudents() async {
    if (universityId.value.isEmpty || studentNim.value.isEmpty) {
      students.clear();
      studentName.value = '';
      return;
    }

    isLoadingStudents.value = true;

    var response = await pddiktiService.findStudentsByNim(
        universityId.value, studentNim.value);
    printResponse(response);

    if (response.status) {
      print("Berhasil");
      students.value = response.data!;
    } else {
      students.clear();
      studentName.value = '';
      printResponse(response);
    }

    isLoadingStudents.value = false;
  }

  Future<void> registerAlumni() async {
    isRegistering.value = true;

    final userData = {
      "user": {
        "phone": phoneNumber.value,
        "email": email.value,
        "password": password.value,
      },
      "name": studentName.value,
      "university_name": universityName.value,
      "gpa": gpa.value,
      "graduation_date": graduationDate.value,
      "major": studentMajor,
      "pddikti_student_id": studentId,
    };

    final response = await alumniService.registerAlumni(userData);

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
