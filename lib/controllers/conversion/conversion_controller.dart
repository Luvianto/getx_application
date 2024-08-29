import 'package:get/get.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/models/conversion/conversion_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/services/conversion_service.dart';
import 'package:getx_application/services/enum_service.dart';

class ConversionController extends GetxController {
  final ConversionService _conversionService = ConversionService();

  var conversions = <ConversionModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var selectedField = ''.obs;
  var fieldName = ''.obs;

  // Body to send when creating a conversion
  var title = ''.obs;
  var description = ''.obs;
  var organizer = ''.obs;
  var date = ''.obs;
  var certificateUrl = ''.obs;
  var fieldId = ''.obs;

  var fieldEnum = [FieldEnum(id: '', name: '')].obs;

  void fetchFields() async {
    var res = await EnumService().fetchFields();
    if (res.status) {
      var data = res.data;
      print('${data![0].id}${data[0].name}');

      selectedField.value = data[0].id;
      fieldEnum.value = res.data!;
    } else {
      Get.snackbar('Fetch Bidang Gagal', 'Coba lagi dalam beberapa saat');
    }
  }

  Future<void> fetchConversions() async {
    isLoading(true);
    final result = await _conversionService.getConversionAlumni();
    if (result.isSuccess) {
      List<dynamic> dynamicList = result.data ?? [];

      conversions.assignAll(dynamicList.map((dynamic data) {
        return ConversionModel(
          id: data['id'],
          title: data['title'],
          organizer: data['organizer'],
          date: data['date'],
          certificateUrl: data['certificate_url'],
          description: data['description'],
          status: data['status'],
          pointGiven: data['point_given'],
          rejectedReason: data['rejected_reason'],
          submittedAt: data['submitted_at'],
        );
      }).toList());

      // conversions.assignAll(result.data ?? []);
    } else {
      errorMessage(result.error);
    }
    isLoading(false);
  }

  Future<void> createConversions() async {
    final conversionData = {
      "field": {
        "id": selectedField.value,
      },
      "title": title.value,
      "description": description.value,
      "organizer": organizer.value,
      "date": date.value,
      "certificate_url": certificateUrl.value
    };

    final response =
        await _conversionService.createConversionAlumni(conversionData);

    if (response.status) {
      // Get.toNamed('/conversion-histories', id: 10);
      Get.snackbar('Berhasil',
          'Konversi poin akan diverifikasi oleh admin, harap cek berkala!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Gagal', 'Mohon coba lagi dalam beberapa saat.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  printResponse(ServiceResult res) {
    print("Response");
    print("status: ${res.status}");
    print("data: ${res.data}");
    print("error: ${res.error}");
  }
}
