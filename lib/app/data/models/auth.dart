import 'package:getx_application/app/data/models/enums.dart';

class IsLoginModel {
  final bool isAdmin;
  final Role role;
  final String uuid;

  IsLoginModel({
    required this.isAdmin,
    required this.role,
    required this.uuid,
  });

  factory IsLoginModel.fromJson(Map<String, dynamic> data) {
    return IsLoginModel(
      isAdmin: data["is_admin"],
      role: Role.fromJson(data["role"]),
      uuid: data["uuid"],
    );
  }
}
