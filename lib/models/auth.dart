import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/models/company/company_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/models/training_institution/training_institution_model.dart';
import 'package:getx_application/models/university/university_model.dart';

class IsLoginModel {
  final bool isAdmin;
  final RoleEnum role;
  final String uuid;

  IsLoginModel({
    required this.isAdmin,
    required this.role,
    required this.uuid,
  });

  factory IsLoginModel.fromJson(Map<String, dynamic> data) {
    return IsLoginModel(
      isAdmin: data["is_admin"],
      role: RoleEnum.fromJson(data["role"]),
      uuid: data["uuid"],
    );
  }
}

class UserModel {
  final String uuid;
  final String phone;
  final String email;
  final String? imageUrl;
  final String? bio;
  final String? country;
  final String? province;
  final String? city;
  final String? subdistrict;
  final String? ward;
  final int status;
  final RoleEnum role;
  final AlumniModel? alumniData;
  final CompanyModel? companyData;
  final UniversityModel? universityData;
  final TrainingInstitutionModel? trainingInstitutionData;
  final String rejectedReason;
  final String createdAt;

  UserModel({
    required this.uuid,
    required this.phone,
    required this.email,
    this.imageUrl,
    this.bio,
    this.country,
    this.province,
    this.city,
    this.subdistrict,
    this.ward,
    required this.status,
    required this.role,
    this.alumniData,
    this.companyData,
    this.universityData,
    this.trainingInstitutionData,
    required this.rejectedReason,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uuid: data["uuid"],
      phone: data["phone"],
      email: data["email"],
      imageUrl: data["image_url"],
      bio: data["bio"],
      country: data["country"],
      province: data["province"],
      city: data["city"],
      subdistrict: data["subdistrict"],
      ward: data["ward"],
      status: data["status"],
      role: RoleEnum.fromJson(data["role"]),
      alumniData: data["alumni_data"] != null
          ? AlumniModel.fromJson(data["alumni_data"])
          : null,
      companyData: data["company_data"] != null
          ? CompanyModel.fromJson(data["company_data"])
          : null,
      universityData: data["university_data"] != null
          ? UniversityModel.fromJson(data["university_data"])
          : null,
      trainingInstitutionData: data["training_institution_data"] != null
          ? TrainingInstitutionModel.fromJson(data["training_institution_data"])
          : null,
      rejectedReason: data["rejected_reason"],
      createdAt: data["created_at"],
    );
  }
}
