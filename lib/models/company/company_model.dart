import 'package:getx_application/models/abstract.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/models/enums.dart';

class CompanyModel implements DetailModel {
  final int id;
  final String companyName;
  final CompanyType companyType;
  final String foundingDate;
  final int employeesNumber;
  final int earlyWorkingHours;
  final int endWorkingHours;
  final UserModel? user;

  CompanyModel({
    required this.id,
    required this.companyName,
    required this.companyType,
    required this.foundingDate,
    required this.employeesNumber,
    required this.earlyWorkingHours,
    required this.endWorkingHours,
    this.user,
  });

  @override
  Map<String, dynamic> getDetail() {
    return {"name": companyName, "key": 'company_name', "editId": 30};
  }

  factory CompanyModel.fromJson(Map<String, dynamic> data) {
    return CompanyModel(
      id: data['id'] ?? '',
      companyName: data['company_name'] ?? '',
      companyType: CompanyType.fromJson(data['company_type']),
      foundingDate: data['founding_date'] ?? '',
      employeesNumber: data['employees_number'] ?? 0,
      earlyWorkingHours: data['early_working_hours'] ?? 0,
      endWorkingHours: data['end_working_hours'] ?? 0,
      user: data["user"] != null ? UserModel.fromJson(data["user"]) : null,
    );
  }
}
