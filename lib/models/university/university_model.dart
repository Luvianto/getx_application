import 'package:getx_application/models/abstract.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/models/pddikti/university_model.dart';

class UniversityModel implements DetailModel {
  final int id;
  final String pddiktiUniversityId;
  final String universityName;
  final UserModel? user;
  final PddiktiUniversityModel? pddiktiData;

  UniversityModel({
    required this.id,
    required this.pddiktiUniversityId,
    required this.universityName,
    this.user,
    this.pddiktiData,
  });

  @override
  Map<String, dynamic> getDetail() {
    return {"name": universityName, "key": 'university_name', "editId": 40};
  }

  factory UniversityModel.fromJson(Map<String, dynamic> data) {
    return UniversityModel(
      id: data['id'] ?? '',
      pddiktiUniversityId: data['pddikti_university_id'] ?? '',
      universityName: data['university_name'] ?? '',
      user: data["user"] != null ? UserModel.fromJson(data["user"]) : null,
      pddiktiData: data["pddikti_data"] != null
          ? PddiktiUniversityModel.fromJson(data["pddikti_data"])
          : null,
    );
  }
}
