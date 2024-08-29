import 'package:get/get.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/enum_service.dart';
import 'package:getx_application/services/vacancy_service.dart';

class CreateVacancyController extends GetxController {
  var position = ''.obs;
  var selectedJobType = 0.obs;
  var selectedField = ''.obs;
  var selectedIncomeType = 0.obs;
  var selectedSkillLevel = 0.obs;
  var description = ''.obs;
  var fileName = ''.obs;
  var earlyDateOfReceipt = ''.obs;
  var finalDateOfReceipt = ''.obs;
  var minSalary = 0.obs;
  var maxSalary = 0.obs;

  var jobTypeEnum = [JobType(id: 0, name: '')].obs;
  var fieldEnum = [FieldEnum(id: '', name: '')].obs;
  var incomeTypeEnum = [IncomeType(id: 0, name: '')].obs;
  var skillLevelEnum = [LevelEnum(id: 0, name: '', minPoint: 0)].obs;

  void fetchJobTypes() async {
    var res = await EnumService().fetchJobTypes();
    if (res.status) {
      var data = res.data;
      print('${data![0].id}${data[0].name}');
      selectedJobType.value = data[0].id;
      jobTypeEnum.value = res.data!;
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  void fetchFields() async {
    var res = await EnumService().fetchFields();
    if (res.status) {
      var data = res.data;
      print('${data![0].id}${data[0].name}');
      selectedField.value = data[0].id;
      fieldEnum.value = res.data!;
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  void fetchIncomeTypes() async {
    var res = await EnumService().fetchIncomeTypes();
    if (res.status) {
      var data = res.data;
      print('${data![0].id}${data[0].name}');
      selectedIncomeType.value = data[0].id;
      incomeTypeEnum.value = res.data!;
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  void fetchSkillLevels() async {
    var res = await EnumService().fetchLevel();
    if (res.status) {
      var data = res.data;
      print('${data![0].id}${data[0].name}');
      selectedSkillLevel.value = data[0].id;
      skillLevelEnum.value = res.data!;
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  Future<bool> postLowonganPekerjaan() async {
    var body = {
      "field": {'id': selectedField.value},
      "job_type": {'id': selectedJobType.value},
      "income_type": {'id': selectedIncomeType.value},
      "level": {'id': selectedSkillLevel.value},
      "position": position.value,
      "thumbnail_url": fileName.value,
      "description": description.value,
      "early_date_of_receipt": earlyDateOfReceipt.value,
      "final_date_of_receipt": finalDateOfReceipt.value,
      "min_salary": minSalary.value,
      "max_salary": maxSalary.value,
    };
    print("Body : $body");
    var res = await VacancyService().postVacancy(body);
    if (res.status) {
      var data = res.data as Map<String, dynamic>;
      Get.snackbar('Post berhasil', '${data['title']}!');
    } else {
      Get.snackbar('Post Gagal', 'Coba lagi dalam beberapa saat');
    }
    return res.status;
  }
}
