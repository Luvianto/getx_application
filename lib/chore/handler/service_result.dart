import 'package:getx_application/chore/handler/api_response.dart';

class ServiceResult<T> {
  final T? data;
  final bool status;
  final String? error;
  final Pagination? pagination;

  ServiceResult._(
      {this.data, this.error, required this.status, this.pagination});

  factory ServiceResult.success(T data, {Pagination? pagination}) =>
      ServiceResult._(data: data, status: true, pagination: pagination);

  factory ServiceResult.failure(String error) =>
      ServiceResult._(error: error, status: false);

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
