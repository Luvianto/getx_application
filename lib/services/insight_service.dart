import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/insight/insight_model.dart';

class InsightService extends ApiInstance {
  Future<ServiceResult<InsightByFieldsModel>> fetchInsightByFields() async {
    final response = await get('/v1/dashboard/university/alumni-insight',
        queryParams: {'month': 'full'});

    if (response.status) {
      return ServiceResult.success(
          InsightByFieldsModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
