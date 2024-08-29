class RoleEnum {
  final String id;
  final String name;

  RoleEnum({
    required this.id,
    required this.name,
  });

  factory RoleEnum.fromJson(Map<String, dynamic> data) {
    return RoleEnum(
      id: data["id"],
      name: data["name"],
    );
  }
}

class FieldEnum {
  String id;
  String name;
  String? point;

  FieldEnum({
    required this.id,
    required this.name,
    this.point,
  });

  factory FieldEnum.fromJson(Map<String, dynamic> data) {
    return FieldEnum(
      id: data['id'].toString(),
      name: data['name'] ?? data['field']['name'] ?? '',
      point: data['point'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'point': point,
    };
  }

  @override
  String toString() {
    return '{id: $id, name: $name, point: $point}';
  }
}

class CompanyType {
  final int id;
  final String name;

  CompanyType({
    required this.id,
    required this.name,
  });

  factory CompanyType.fromJson(Map<String, dynamic> data) {
    return CompanyType(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
    );
  }
}

class ApplicationStage {
  final int id;
  final String name;

  ApplicationStage({
    required this.id,
    required this.name,
  });

  factory ApplicationStage.fromJson(Map<String, dynamic> data) {
    return ApplicationStage(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
    );
  }
}

class LevelEnum {
  final int id;
  final String name;
  final int minPoint;

  LevelEnum({
    required this.id,
    required this.name,
    required this.minPoint,
  });

  factory LevelEnum.fromJson(Map<String, dynamic> data) {
    return LevelEnum(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      minPoint: data['min_point'] ?? '',
    );
  }
}

class JobType {
  int id;
  String name;

  JobType({
    required this.id,
    required this.name,
  });

  factory JobType.fromJson(Map<String, dynamic> json) {
    return JobType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class IncomeType {
  int id;
  String name;

  IncomeType({
    required this.id,
    required this.name,
  });

  factory IncomeType.fromJson(Map<String, dynamic> json) {
    return IncomeType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
