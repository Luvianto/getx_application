import 'package:getx_application/chore/handler/service_result.dart';
import 'package:getx_application/chore/instance/api_instance.dart';

class FileService extends ApiInstance {
  Future<ServiceResult<String>> uploadFile(
      Map<String, dynamic> fileData) async {
    final response =
        await postFile('/v1/file', fileData['file'], fileData['fileName']);
    if (response.status) {
      return ServiceResult.success(response.data);
    } else {
      return ServiceResult.failure("Error uploading file");
    }
  }

  Future<ServiceResult<dynamic>> deleteFile(String id) async {
    final response = await delete('/v1/file/$id');
    if (response.status) {
      return ServiceResult.success(null);
    } else {
      return ServiceResult.failure("Error deleting file");
    }
  }

  Future<bool> validateFileById(String imageURLID) async {
    return await validateFile(imageURLID);
  }
}
