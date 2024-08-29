import 'package:getx_application/models/notification/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';

class NotificationService extends ApiInstance {
  Future<ServiceResult<List<NotificationModel>>> getNotifications(
      {Map<String, String>? params}) async {
    final prefs = await SharedPreferences.getInstance();

    final response = await get('/v1/notifications/${prefs.getString('uuid')}',
        queryParams: params);

    if (response.status) {
      final List<NotificationModel> notifications = [];

      for (final item in response.data) {
        notifications.add(NotificationModel.fromJson(item));
      }

      return ServiceResult.success(
        notifications,
        pagination: response.pagination,
      );
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
