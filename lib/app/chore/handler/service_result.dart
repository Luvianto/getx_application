class ServiceResult<T> {
  final T? data;
  final bool status;
  final String? error;

  ServiceResult._({this.data, this.error, required this.status});

  factory ServiceResult.success(T data) =>
      ServiceResult._(data: data, status: true);
  factory ServiceResult.failure(String error) =>
      ServiceResult._(error: error, status: false);

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
