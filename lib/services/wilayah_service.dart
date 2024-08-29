import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getx_application/models/wilayah/wilayah_model.dart';
import 'package:http/http.dart' as http;
import 'package:getx_application/chore/handler/service_result.dart';

class WilayahService {
  final String? baseUrl = dotenv.env['WILAYAH_API_URL'];

  Future<ServiceResult<List<WilayahModel>>> fetchAllProvinces() async {
    final url = '$baseUrl/provinces.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> dataList = jsonResponse['data'];
      List<WilayahModel> provinces = dataList
          .map((data) => WilayahModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(provinces);
    } else {
      return ServiceResult.failure('Failed to fetch provinces');
    }
  }

  Future<ServiceResult<List<WilayahModel>>> fetchRegenciesByProvince(
      String provinceCode) async {
    final url = '$baseUrl/regencies/$provinceCode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> dataList = jsonResponse['data'];
      List<WilayahModel> regencies = dataList
          .map((data) => WilayahModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(regencies);
    } else {
      return ServiceResult.failure('Failed to fetch regencies');
    }
  }

  Future<ServiceResult<List<WilayahModel>>> fetchDistrictsByCity(
      String cityCode) async {
    final url = '$baseUrl/districts/$cityCode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> dataList = jsonResponse['data'];
      List<WilayahModel> districts = dataList
          .map((data) => WilayahModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return ServiceResult.success(districts);
    } else {
      return ServiceResult.failure('Failed to fetch districts');
    }
  }
}
