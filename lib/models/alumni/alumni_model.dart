import 'package:getx_application/models/abstract.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/models/pddikti/student_model.dart';

class AlumniModel implements DetailModel {
  final int? id;
  final String? pddiktiStudentId;
  final String? name;
  final String? universityName;
  final double? gpa;
  final String? graduationDate;
  final List<FieldEnum>? fields;
  final String? major;
  final FieldEnum? focusField;
  final UserModel? user;
  final PddiktiStudentModel? pddiktiData;

  AlumniModel({
    this.id,
    this.pddiktiStudentId,
    this.name,
    this.universityName,
    this.gpa,
    this.graduationDate,
    this.fields,
    this.major,
    this.focusField,
    this.user,
    this.pddiktiData,
  });

  @override
  Map<String, dynamic> getDetail() {
    return {"name": name, "key": 'name', "editId": 12};
  }

  factory AlumniModel.fromJson(Map<String, dynamic> data) {
    return AlumniModel(
      id: data['id'] ?? '',
      pddiktiStudentId: data['pddikti_student_id'] ?? '',
      name: data['name'] ?? '',
      universityName: data['university_name'] ?? '',
      gpa: data['gpa'].toDouble() ?? 0.0,
      graduationDate: data['graduation_date'] ?? '',
      fields: (data['fields'] as List)
          .map((field) => FieldEnum.fromJson(field))
          .toList(),
      major: data['major'] ?? '',
      focusField: data["focus_field"] != null
          ? FieldEnum.fromJson(data["focus_field"])
          : null,
      user: data["user"] != null ? UserModel.fromJson(data["user"]) : null,
      pddiktiData: data["pddikti_data"] != null
          ? PddiktiStudentModel.fromJson(data["pddikti_data"])
          : null,
    );
  }
}
