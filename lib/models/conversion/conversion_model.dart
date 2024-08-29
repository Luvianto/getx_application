class ConversionModel {
  final int id;
  final String title;
  final String organizer;
  final String date;
  final String certificateUrl;
  final String description;
  final int status;
  final int pointGiven;
  final String rejectedReason;
  final String submittedAt;

  ConversionModel({
    required this.id,
    required this.title,
    required this.organizer,
    required this.date,
    required this.certificateUrl,
    required this.description,
    required this.status,
    required this.pointGiven,
    required this.rejectedReason,
    required this.submittedAt,
  });

  factory ConversionModel.fromJson(Map<String, dynamic> data) {
    return ConversionModel(
      id: data['id'],
      title: data['title'],
      organizer: data['organizer'],
      date: data['date'],
      certificateUrl: data['certificate_url'],
      description: data['description'],
      status: data['status'],
      pointGiven: data['point_given'],
      rejectedReason: data['rejected_reason'],
      submittedAt: data['submitted_at'],
    );
  }
}
