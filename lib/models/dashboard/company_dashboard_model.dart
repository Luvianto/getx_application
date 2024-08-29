import 'package:getx_application/common/models/month_data.dart';

class CompanyDashboardModel {
  final AlumniAcceptedPerMonth? alumniAcceptedPerMonth;
  final int? totalVacancy;
  final int? totalAlumniAccepted;

  CompanyDashboardModel({
    this.alumniAcceptedPerMonth,
    this.totalVacancy,
    this.totalAlumniAccepted,
  });

  factory CompanyDashboardModel.fromJson(Map<String, dynamic> json) {
    return CompanyDashboardModel(
      alumniAcceptedPerMonth:
          AlumniAcceptedPerMonth.fromJson(json['alumni_accepted_per_month']),
      totalVacancy: json['total_vacancy'] as int,
      totalAlumniAccepted: json['total_alumni_accepted'] as int,
    );
  }
}

class AlumniAcceptedPerMonth {
  final String year;
  final List<MonthData> month;

  AlumniAcceptedPerMonth({
    required this.year,
    required this.month,
  });

  factory AlumniAcceptedPerMonth.fromJson(Map<String, dynamic> json) {
    var monthList = (json['month'] as List)
        .map((monthJson) => MonthData.fromJson(monthJson))
        .toList();

    return AlumniAcceptedPerMonth(
      year: json['year'] as String,
      month: monthList,
    );
  }
}
