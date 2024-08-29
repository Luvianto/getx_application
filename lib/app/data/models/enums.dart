class Role {
  final String? id;
  final String? name;

  Role({
    this.id,
    this.name,
  });

  factory Role.fromJson(Map<String, dynamic> data) {
    return Role(
      id: data["id"] ?? '',
      name: data["name"] ?? '',
    );
  }
}
