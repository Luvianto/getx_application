class AlumniDashboardModel {
  final Field? field;
  final Recommended? recommendedVacancy;
  final Recommended? recommendedTraining;

  AlumniDashboardModel(
      {this.field, this.recommendedVacancy, this.recommendedTraining});

  factory AlumniDashboardModel.fromJson(Map<String, dynamic> json) {
    return AlumniDashboardModel(
      field: json['field'] != null
          ? Field.fromJson(json['field'])
          : Field(id: '', name: '', point: 0),
      recommendedVacancy: json['recommended_vacancy'] != null
          ? Recommended.fromJson(json['recommended_vacancy'])
          : Recommended(total: 0),
      recommendedTraining: json['recommended_training'] != null
          ? Recommended.fromJson(json['recommended_training'])
          : Recommended(total: 0),
    );
  }
}

class Field {
  final String? id;
  final String? name;
  final int? point;

  Field({this.id, this.name, this.point});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'] as String?,
      name: json['name'] as String?,
      point: json['point'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'point': point,
    };
  }
}

class Recommended {
  final int? total;

  Recommended({this.total});

  factory Recommended.fromJson(Map<String, dynamic> json) {
    return Recommended(
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
    };
  }
}
