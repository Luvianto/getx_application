import 'package:getx_application/models/abstract.dart';
import 'package:getx_application/models/auth.dart';

class TrainingInstitutionModel implements DetailModel {
  final int id;
  final String institutionName;
  final UserModel? user;

  TrainingInstitutionModel({
    required this.id,
    required this.institutionName,
    this.user,
  });

  @override
  Map<String, dynamic> getDetail() {
    return {"name": institutionName, "key": 'institution_name', "editId": 22};
  }

  factory TrainingInstitutionModel.fromJson(Map<String, dynamic> data) {
    return TrainingInstitutionModel(
      id: data['id'] ?? '',
      institutionName: data['institution_name'] ?? '',
      user: data["user"] != null ? UserModel.fromJson(data["user"]) : null,
    );
  }
}
