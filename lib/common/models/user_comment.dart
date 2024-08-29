class UserCommentModel {
  final String? uuid;
  final String? name;
  final String? imageUrl;

  UserCommentModel({
    required this.uuid,
    required this.name,
    required this.imageUrl,
  });

  factory UserCommentModel.fromJson(Map<String, dynamic> data) {
    return UserCommentModel(
      uuid: data['uuid'],
      name: data['name'],
      imageUrl: data['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
