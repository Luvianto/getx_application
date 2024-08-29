import 'package:getx_application/common/models/month_data.dart';

Map<String, double> parseMonthData(List<MonthData> data) {
  Map<String, double> resultMap = {};

  for (var item in data) {
    String shortMonth = item.month.substring(0, 3);
    resultMap[shortMonth] = item.value.toDouble();
  }

  return resultMap;
}
