import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/data/models/pddikti/alumni_pddikti_model.dart';
import 'package:getx_application/app/data/models/pddikti/university_pddikti_model.dart';
import 'package:getx_application/app/services/pddikti_service.dart';

class AlumniCreateController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final universityController = TextEditingController();
  final alumniController = TextEditingController();
  final gpaController = TextEditingController();

  var isSelectingUniversity = false.obs;
  var universityName = ''.obs;

  var isLoadingUniversities = false.obs;
  var universities = <UniversityPddiktiModel>[].obs;
  var universityId = ''.obs;

  var isSelectingAlumni = false.obs;
  var nim = ''.obs;

  var isLoadingAlumnis = false.obs;
  var alumnis = <AlumniPddiktiModel>[].obs;

  var studentName = ''.obs;

  String studentMajor = '';
  String studentId = '';

  var gpa = 0.0.obs;
  var graduationDate = ''.obs;

  @override
  void onInit() {
    super.onInit();

    debounce(universityName, (_) {
      if (!isSelectingUniversity.value) {
        fetchUniversities();
      }
    }, time: const Duration(milliseconds: 1000));

    debounce(nim, (_) {
      if (!isSelectingAlumni.value) {
        fetchStudents();
      }
    }, time: const Duration(milliseconds: 1000));
  }

  void deleteUniversityName() {
    universityId.value = '';
    isSelectingUniversity.value = true;
    alumnis.clear();
    nim.value = '';
    isSelectingAlumni.value = false;
  }

  Future<void> fetchUniversities() async {
    if (universityName.value.isEmpty) {
      universities.clear();
      return;
    }

    isLoadingUniversities.value = true;
    var response =
        await PddiktiService().findUniversitiesByName(universityName.value);

    if (response.status) {
      universities.value = response.data!;
    } else {
      universities.clear();
      universityId.value = '';
    }
    isLoadingUniversities.value = false;
  }

  Future<void> fetchStudents() async {
    if (universityId.value.isEmpty || nim.value.isEmpty) {
      alumnis.clear();
      studentName.value = '';
      return;
    }

    isLoadingAlumnis.value = true;

    var response =
        await PddiktiService().findStudentsByNim(universityId.value, nim.value);

    if (response.status) {
      alumnis.value = response.data!;
    } else {
      alumnis.clear();
      studentName.value = '';
    }

    isLoadingAlumnis.value = false;
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
}
