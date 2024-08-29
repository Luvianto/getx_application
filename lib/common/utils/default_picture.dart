import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Widget handleUserPicture(String imageURL, {double size = 30.0}) {
  final validExtensions = ['png', 'jpg', 'jpeg', 'gif'];

  bool isValidImageUrl =
      validExtensions.any((ext) => imageURL.toLowerCase().endsWith(ext));

  String baseUrl = dotenv.env['BASE_URL']!;
  double avatarSize = size;

  if (isValidImageUrl) {
    return CircleAvatar(
      radius: avatarSize / 2,
      backgroundImage: NetworkImage('$baseUrl/v1/file/$imageURL'),
      onBackgroundImageError: (error, stackTrace) {
        Icon(Icons.person, size: avatarSize);
      },
    );
  } else {
    return CircleAvatar(
      radius: avatarSize / 2,
      child: Icon(Icons.person, size: avatarSize),
    );
  }
}
