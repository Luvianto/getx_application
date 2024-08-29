import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:getx_application/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';

class AuthService extends ApiInstance {
  Future<String> getFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken!;
    } catch (e) {
      throw Exception("Error Fetching FcmToken: $e");
    }
  }

  Future<ServiceResult<dynamic>> signIn(Map<String, dynamic> body) async {
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

  Future<ServiceResult<UserModel>> getUserByUuid() async {
    final prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('uuid');

    final res = await get('/v1/users/details/$uuid');
    if (res.status) {
      return ServiceResult.success(UserModel.fromJson(res.data));
    } else {
      return ServiceResult.failure(res.message);
    }
  }

  Future<ServiceResult<dynamic>> sendResetPasswordRequest(String email) async {
    final res = await post('/v1/reset-password', {"email": email});
    if (res.status) {
      return ServiceResult.success(res.data);
    } else {
      return ServiceResult.failure(res.message);
    }
  }
}
