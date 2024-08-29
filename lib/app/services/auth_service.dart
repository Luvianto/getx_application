import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:getx_application/app/chore/handler/service_result.dart';
import 'package:getx_application/app/chore/instance/api_instance.dart';
import 'package:getx_application/app/data/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ApiInstance {
  Future<String> getFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken!;
    } catch (e) {
      throw Exception("Error Fetching FcmToken: $e");
    }
  }

  Future<ServiceResult<dynamic>> signIn(String email, String password) async {
    String fcmToken = '';

    try {
      fcmToken = await getFcmToken();
    } catch (e) {
      return ServiceResult.failure(e.toString());
    }

    var body = {
      "email": email,
      "password": password,
      "fcm_token": fcmToken,
    };

    final response = await post('/v1/signin', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<dynamic>> signOut(Map<String, dynamic> body) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      return ServiceResult.failure("Gagal Logout");
    }
    return ServiceResult.success(null);
  }

  Future<ServiceResult<IsLoginModel>> isLogin() async {
    final res = await get('/v1/is-login');
    if (res.status) {
      return ServiceResult.success(IsLoginModel.fromJson(res.data));
    } else {
      return ServiceResult.failure(res.message);
    }
  }

  Future<ServiceResult<dynamic>> checkEmail(String email) async {
    final res = await get('/v1/check-email/$email');
    if (res.status) {
      return ServiceResult.success(res.data);
    } else {
      return ServiceResult.failure(res.message);
    }
  }
}
