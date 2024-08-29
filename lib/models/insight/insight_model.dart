class InsightByFieldsModel {
  TotalAlumni? totalAlumni;
  List<Fields>? fields;

  InsightByFieldsModel({
    this.totalAlumni,
    this.fields,
  });

  factory InsightByFieldsModel.fromJson(Map<String, dynamic> json) {
    return InsightByFieldsModel(
      totalAlumni: TotalAlumni.fromJson(json['total_alumni']),
      fields: (json['fields'] as List)
          .map((item) => Fields.fromJson(item))
          .toList(),
    );
  }
}

class TotalAlumni {
  int all;
  int withFocusField;
  int withoutFocusField;

  TotalAlumni({
    required this.all,
    required this.withFocusField,
    required this.withoutFocusField,
  });

  factory TotalAlumni.fromJson(Map<String, dynamic> json) {
    return TotalAlumni(
      all: json['all'],
      withFocusField: json['with_focus_field'],
      withoutFocusField: json['without_focus_field'],
    );
  }
}

class Fields {
  String name;
  int total;

  Fields({
    required this.name,
    required this.total,
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      name: json['name'],
      total: json['total'],
    );
  }
}
