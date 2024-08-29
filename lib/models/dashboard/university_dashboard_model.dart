import 'package:getx_application/common/models/month_data.dart';

class UniversityDashboardModel {
  AlumniAcceptedPerMonth? alumniAcceptedPerMonth;
  List<AlumniAcceptedByCompanyType>? alumniAcceptedByCompanyType;

  UniversityDashboardModel({
    this.alumniAcceptedPerMonth,
    this.alumniAcceptedByCompanyType,
  });

  factory UniversityDashboardModel.fromJson(Map<String, dynamic> json) {
    return UniversityDashboardModel(
      alumniAcceptedPerMonth:
          AlumniAcceptedPerMonth.fromJson(json['alumni_accepted_per_month']),
      alumniAcceptedByCompanyType:
          (json['alumni_accepted_by_company_type'] as List)
              .map((item) => AlumniAcceptedByCompanyType.fromJson(item))
              .toList(),
    );
  }
}

class AlumniAcceptedPerMonth {
  String year;
  List<MonthData> month;

  AlumniAcceptedPerMonth({
    required this.year,
    required this.month,
  });

  factory AlumniAcceptedPerMonth.fromJson(Map<String, dynamic> json) {
    return AlumniAcceptedPerMonth(
      year: json['year'],
      month: (json['month'] as List)
          .map((item) => MonthData.fromJson(item))
          .toList(),
    );
  }
}

class AlumniAcceptedByCompanyType {
  String companyTypeName;
  String year;
  int total;

  AlumniAcceptedByCompanyType({
    required this.companyTypeName,
    required this.year,
    required this.total,
  });

  factory AlumniAcceptedByCompanyType.fromJson(Map<String, dynamic> json) {
    return AlumniAcceptedByCompanyType(
      companyTypeName: json['company_type_name'],
      year: json['year'],
      total: json['total'],
    );
  }
}
