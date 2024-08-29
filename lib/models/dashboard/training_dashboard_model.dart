import 'package:getx_application/common/models/month_data.dart';

class TrainingDashboardModel {
  final AlumniJoinedPerMonth? alumniJoined;

  TrainingDashboardModel({
    this.alumniJoined,
  });

  factory TrainingDashboardModel.fromJson(Map<String, dynamic> json) {
    return TrainingDashboardModel(
      alumniJoined:
          AlumniJoinedPerMonth.fromJson(json['alumni_joined_per_month']),
    );
  }
}

class AlumniJoinedPerMonth {
  final String? year;
  final List<MonthData>? month;

  AlumniJoinedPerMonth({
    this.year,
    this.month,
  });

  factory AlumniJoinedPerMonth.fromJson(Map<String, dynamic> json) {
    return AlumniJoinedPerMonth(
      year: json['year'] as String,
      month: (json['month'] as List<dynamic>)
          .map((item) => MonthData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
