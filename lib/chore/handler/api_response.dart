class ApiResponse<T> {
  final bool status;
  final int statusCode;
  final String message;
  final List<ApiFieldError>? errors;
  final T? data;
  final Pagination? pagination;

  ApiResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.errors,
    this.data,
    this.pagination,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      statusCode: json['status_code'],
      message: json['message'],
      errors: (json['errors'] as List?)
          ?.map((e) => ApiFieldError.fromJson(e))
          .toList(),
      data: json['data'],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  static String getErrorMessage(dynamic error) {
    return error is ApiResponse ? error.message : 'Unknown error occurred';
  }
}

class ApiFieldError {
  final String field;
  final String message;

  ApiFieldError._(this.field, this.message);

  factory ApiFieldError.fromJson(Map<String, dynamic> json) {
    return ApiFieldError._(json['field'], json['message']);
  }
}

class Pagination {
  final int? page;
  final int? limit;
  final int? totalItems;
  final int? totalPages;

  Pagination({
    this.page,
    this.limit,
    this.totalItems,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      totalItems: json['total_items'],
      totalPages: json['total_pages'],
    );
  }
}
