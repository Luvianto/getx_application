import 'package:get/get.dart';
import 'package:getx_application/models/insight/insight_model.dart';
import 'package:getx_application/services/insight_service.dart';

class InsightController extends GetxController {
  var isLoading = false.obs;

  InsightService insightService = InsightService();

  var insightByFieldsData = InsightByFieldsModel().obs;

  void fetchInsightByFields() async {
    isLoading.value = true;
    var res = await insightService.fetchInsightByFields();
    if (res.status) {
      insightByFieldsData.value = res.data!;
    } else {
      print(res.error);
    }
    isLoading.value = false;
  }
}
