import 'package:teck_talk/core/data/models/pagination_model.dart';
import 'package:teck_talk/core/data/models/post_model.dart';

class PostsResponse {
  final String status;
  final String message;
  final List<PostSavedModel> data;
  final PaginationModel pagination;

  PostsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      status: _readString(json['status']),
      message: _readString(json['message']),
      data: (json['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(PostSavedModel.fromJson)
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }

  static String _readString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is Map<String, dynamic>) {
      for (final key in const ['message', 'status', 'title', 'name', 'value']) {
        final candidate = value[key];
        if (candidate != null) {
          final asString = _readString(candidate);
          if (asString.isNotEmpty) return asString;
        }
      }
    }
    return value.toString();
  }
}
