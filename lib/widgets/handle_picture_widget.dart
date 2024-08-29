import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getx_application/controllers/file/file_controller.dart';

Widget handlePictureWidget({
  required String? imageUrl,
  required double height,
  required double width,
}) {
  final validExtensions = ['png', 'jpg', 'jpeg', 'gif'];

  const defaultImageUrl =
      '17239679559d4e42fd5c3fb47affc283548e6d7eab-No_Image_Available.jpg';

  String baseUrl = dotenv.env['BASE_URL']!;

  return FutureBuilder<String>(
    future: () async {
      final bool isValidFile = await FileController().isValidFile(imageUrl!);
      if (isValidFile &&
          !imageUrl.contains('/') &&
          imageUrl.isNotEmpty &&
          validExtensions.any((ext) => imageUrl.toLowerCase().endsWith(ext))) {
        return '$baseUrl/v1/file/$imageUrl';
      } else {
        return '$baseUrl/v1/file/$defaultImageUrl';
      }
    }(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            snapshot.data!,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height,
            width: width,
            color: Colors.grey,
            child: Image.network(
              '$baseUrl/v1/file/$defaultImageUrl',
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    },
  );
}
