class ApplicationJourneyModel {
  final int? id;
  final String? name;
  final String? date;

  ApplicationJourneyModel({
    this.id,
    this.name,
    this.date,
  });

  factory ApplicationJourneyModel.fromJson(Map<String, dynamic> data) {
    return ApplicationJourneyModel(
      id: data['id'],
      name: data['name'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
    };
  }
}
