import 'package:getx_application/models/company/company_model.dart';
import 'package:getx_application/models/dashboard/alumni_dashboard_model.dart';
import 'package:getx_application/models/enums.dart';

class VacancyModel {
  final int? id;
  final Field? field;
  final JobType? jobType;
  final IncomeType? incomeType;
  final CompanyModel? company;
  final LevelEnum? level;
  final String? position;
  final String? thumbnailUrl;
  final String? description;
  final String? earlyDateOfReceipt;
  final String? finalDateOfReceipt;
  final int? minSalary;
  final int? maxSalary;
  final int? appliedCount;
  final int? likesTotal;
  final int? commentsTotal;
  final bool? isApplied;
  final bool? isLiked;

  VacancyModel({
    this.id,
    this.field,
    this.jobType,
    this.incomeType,
    this.company,
    this.level,
    this.position,
    this.thumbnailUrl,
    this.description,
    this.earlyDateOfReceipt,
    this.finalDateOfReceipt,
    this.minSalary,
    this.maxSalary,
    this.appliedCount,
    this.likesTotal,
    this.commentsTotal,
    this.isApplied,
    this.isLiked,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> json) {
    return VacancyModel(
      id: json['id'],
      field: Field.fromJson(json['field']),
      jobType: JobType.fromJson(json['job_type']),
      incomeType: IncomeType.fromJson(json['income_type']),
      company: CompanyModel.fromJson(json['company']),
      level: LevelEnum.fromJson(json['level']),
      position: json['position'],
      thumbnailUrl: json['thumbnail_url'],
      description: json['description'],
      earlyDateOfReceipt: json['early_date_of_receipt'],
      finalDateOfReceipt: json['final_date_of_receipt'],
      minSalary: json['min_salary'],
      maxSalary: json['max_salary'],
      appliedCount: json['applied_count'],
      likesTotal: json['likes_total'],
      commentsTotal: json['comments_total'],
      isApplied: json['is_applied'],
      isLiked: json['is_liked'],
    );
  }
}
