class NotificationModel {
  final String title;
  final String body;
  final String thumbnailURL;
  final String type;
  final String itemID;
  final String createdAt;

  NotificationModel({
    required this.title,
    required this.body,
    required this.thumbnailURL,
    required this.type,
    required this.itemID,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> data) {
    return NotificationModel(
      title: data['title'],
      body: data['body'],
      thumbnailURL: data['thumbnail_url'] ?? '',
      type: data['type'] ?? '',
      itemID: data['item_id'] ?? '',
      createdAt: data['created_at'],
    );
  }
}
