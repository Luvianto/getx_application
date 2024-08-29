import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/models/application/application_journey_model.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';

class ApplicationModel {
  final int? id;
  final AlumniModel? alumni;
  final VacancyModel? vacancy;
  final int? status;
  final String? resumeUrl;
  final List<ApplicationJourneyModel>? applicationJourney;

  ApplicationModel({
    this.id,
    this.alumni,
    this.vacancy,
    this.status,
    this.resumeUrl,
    this.applicationJourney,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> dynamicMap = {
      "id": data['vacancy']['id'],
      "field": data['vacancy']['field'],
      "job_type": data['vacancy']['job_type'],
      "income_type": data['vacancy']['income_type'],
      "company": data['vacancy']['company'],
      "level": data['vacancy']['level'],
      "position": data['vacancy']['position'],
      "thumbnail_url": data['vacancy']['thumbnail_url'],
      "description": data['vacancy']['description'],
      "early_date_of_receipt": data['vacancy']['early_date_of_receipt'],
      "final_date_of_receipt": data['vacancy']['final_date_of_receipt'],
      "min_salary": data['vacancy']['min_salary'],
      "max_salary": data['vacancy']['max_salary'],
      "applied_count": data['vacancy']['applied_count'],
      "likes_total": data['vacancy']['likes_total'],
      "comments_total": data['vacancy']['comments_total'],
      "is_applied": true,
      "is_liked": data['vacancy']['is_liked'] ?? false,
    };

    return ApplicationModel(
      id: data['id'],
      alumni: AlumniModel.fromJson(data['alumni']),
      vacancy: VacancyModel.fromJson(dynamicMap),
      status: data['status'],
      resumeUrl: data['resume_url'],
      applicationJourney: (data['application_journey'] as List)
          .map((journey) => ApplicationJourneyModel.fromJson({
                "id": journey['id'],
                "name": journey['name'],
                "date": journey['date'],
              }))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alumni': alumni!,
      'vacancy': vacancy,
      'status': status,
      'resume_url': resumeUrl,
      'application_journey': applicationJourney,
    };
  }
}
