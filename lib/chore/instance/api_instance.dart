import 'package:getx_application/chore/handler/api_response.dart';
import 'package:getx_application/chore/instance/device_info_instance.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class ApiInstance {
  String baseUrl = dotenv.env['BASE_URL']!;
  Map<String, String> headers = {'Content-Type': 'application/json'};
  String deviceType = DeviceInfoInstance().deviceType;

  Future<void> _loadHeaders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      headers['uuid'] = prefs.getString('uuid') ?? '';
      headers['access_token'] = prefs.getString('access_token') ?? '';
      headers['refresh_token'] = prefs.getString('refresh_token') ?? '';
      headers['device'] = deviceType;
    } catch (e) {
      throw Exception("Error loading Headers: $e");
    }
  }

  Future<void> _updateHeadersFromResponse(http.Response response) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (response.body.isNotEmpty) {
        try {
          if (response.body.startsWith('<') && response.body.endsWith('>')) {
            throw Exception(
                "Received HTML error page instead of JSON response");
          }

          final responseData = json.decode(response.body);

          if (responseData['status'] == true &&
              responseData.containsKey('data')) {
            final data = responseData['data'];
            if (data is Map<String, dynamic> &&
                data.containsKey('role') &&
                data['role'] != null &&
                data['role'].containsKey('name') &&
                data['role']['name'].isNotEmpty) {
              await prefs.setString('role', data['role']['name']);
            } else if (data is List<dynamic>) {
              for (var item in data) {
                if (item is Map<String, dynamic> &&
                    item.containsKey('role') &&
                    item['role'] != null &&
                    item['role'].containsKey('name') &&
                    item['role']['name'].isNotEmpty) {
                  await prefs.setString('role', item['role']['name']);
                  break;
                }
              }
            }
          }
        } catch (e) {
          throw Exception("Error decoding response body: $e");
        }
      }

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
      // ignore: empty_catches
    } catch (e) {}
  }

  void setBaseUrl(String url) {
    baseUrl = url;
  }

  void setHeaders(Map<String, String> headers) {
    this.headers = headers;
  }

  Future<ApiResponse> get(
    String endpoint, {
    Map<String, String>? queryParams,
    bool loadHeaders = true,
  }) async {
    if (loadHeaders) {
      await _loadHeaders();
    }

    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.body == '404 page not found') {
      return ApiResponse(
        status: false,
        statusCode: 404,
        message: 'Page not found',
      );
    }

    if (loadHeaders) {
      await _updateHeadersFromResponse(response);
    }
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

  Future<ApiResponse> postFile(
      String endpoint, List<int> body, String fileName) async {
    await _loadHeaders();

    final uri = Uri.parse('$baseUrl$endpoint');
    final mimeType = lookupMimeType(fileName)!.split('/');
    var request = http.MultipartRequest('POST', uri);

    var multipartFile = http.MultipartFile.fromBytes(
      'file',
      body,
      filename: fileName,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    request.files.add(multipartFile);
    request.headers.addAll(headers);

    var response = await request.send();
    var result = await _getPostFileResponse(response);

    if (result['status']) {
      return ApiResponse(
          status: true,
          data: result['data']['url_id'],
          statusCode: 201,
          message: 'Sukses mendapatkan gambar');
    } else {
      return ApiResponse(
          status: false, statusCode: 500, message: 'Error uploading file');
    }
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

  Future<ApiResponse> patch<T>(String endpoint, T body) async {
    await _loadHeaders();
    final response = await http.patch(
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

  Future<bool> validateFile(String url) async {
    final uri = Uri.parse('$baseUrl/v1/file/$url');
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
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

  Future<Map<String, dynamic>> _getPostFileResponse(
      http.StreamedResponse response) async {
    final responseBody = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(responseBody);
    return jsonResponse;
  }
}
