import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx_application/app/chore/handler/api_response.dart';

class ApiInstance {
  String baseUrl = dotenv.env['BASE_URL']!;
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<void> _loadHeaders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      headers['uuid'] = prefs.getString('uuid') ?? '';
      headers['access_token'] = prefs.getString('access_token') ?? '';
      headers['refresh_token'] = prefs.getString('refresh_token') ?? '';
    } catch (e) {
      throw Exception("Error loading Headers: $e");
    }
  }

  Future<void> _updateHeadersFromResponse(http.Response response) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (response.headers.containsKey('uuid')) {
        await prefs.setString('uuid', response.headers['uuid']!);
      }
      if (response.headers.containsKey('access_token')) {
        await prefs.setString(
            'access_token', response.headers['access_token']!);
      }
      if (response.headers.containsKey('refresh_token')) {
        await prefs.setString(
            'refresh_token', response.headers['refresh_token']!);
      }
      await _loadHeaders();
    } catch (e) {
      throw Exception("Error updating Headers: $e");
    }
  }

  void setBaseUrl(String url) {
    baseUrl = url;
  }

  void setHeaders(Map<String, String> headers) {
    this.headers = headers;
  }

  Future<ApiResponse> get(String endpoint) async {
    await _loadHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    await _updateHeadersFromResponse(response);
    return _handleResponse(response);
  }

  Future<ApiResponse> post<T>(String endpoint, T body) async {
    await _loadHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    await _updateHeadersFromResponse(response);
    return _handleResponse(response);
  }

  Future<ApiResponse> put<T>(String endpoint, T body) async {
    await _loadHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    await _updateHeadersFromResponse(response);
    return _handleResponse(response);
  }

  Future<ApiResponse> delete(String endpoint) async {
    await _loadHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    await _updateHeadersFromResponse(response);
    return _handleResponse(response);
  }

  ApiResponse _handleResponse(http.Response rawResponse) {
    try {
      final decodedResponse = json.decode(rawResponse.body);
      final response = ApiResponse.fromJson(decodedResponse);
      if (response.status) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'An unknown error occurred',
      );
    }
  }
}
