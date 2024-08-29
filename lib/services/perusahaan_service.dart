import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';
import 'package:getx_application/models/company/company_model.dart';

class PerusahaanService extends ApiInstance {
  Future<ServiceResult<CompanyModel>> registerPerusahaan(Object body) async {
    final response = await post('/v1/signup/66b20dd72e8f821ef37dacfc', body);

    if (response.status) {
      return ServiceResult.success(CompanyModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<CompanyModel>> getPerusahaanById(String id) async {
    final response = await get('/v1/companies/$id');

    if (response.status) {
      return ServiceResult.success(CompanyModel.fromJson(response.data));
    } else {
      return ServiceResult.failure(response.message);
    }
  }

  Future<ServiceResult<void>> updatePerusahaan(Object body) async {
    final response = await put('/v1/companies', body);

    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure(response.message);
    }
  }
}
