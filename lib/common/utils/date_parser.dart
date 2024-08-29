import 'package:intl/intl.dart';

String formatTimestamp(String timestamp, {bool isDateOnly = false}) {
  try {
    DateTime dateTime = DateTime.parse(timestamp).toLocal();
    DateFormat outputFormat;

    if (isDateOnly) {
      outputFormat = DateFormat('d MMM yyyy');
    } else {
      outputFormat = DateFormat('h:mm a, d MMM yyyy');
    }

    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  } catch (e) {
    return timestamp;
  }
}

String parseToTimeAgo(String timestamp) {
  final parsedTimestamp = DateTime.parse(timestamp).toLocal();
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inSeconds < 60) {
    return 'baru saja';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} menit yang lalu';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} jam yang lalu';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} hari yang lalu';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} minggu yang lalu';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} bulan yang lalu';
  } else {
    return '${(difference.inDays / 365).floor()} tahun yang lalu';
  }
}
