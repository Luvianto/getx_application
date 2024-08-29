class MonthData {
  String month;
  int value;

  MonthData({
    required this.month,
    required this.value,
  });

  factory MonthData.fromJson(Map<String, dynamic> json) {
    return MonthData(
      month: json['month'],
      value: json['value'],
    );
  }
}
