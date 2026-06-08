import 'package:tech_talk/core/data/responses/post_comments_response.dart';

class ChildCommentsResponse {
  final String status;
  final String message;
  final ChildCommentsData data;

  ChildCommentsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChildCommentsResponse.fromJson(Map<String, dynamic> json) {
    return ChildCommentsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: ChildCommentsData.fromJson(json['data'] ?? {}),
    );
  }
}

class ChildCommentsData {
  final List<CommentModel> children;
  final int totalPages;

  ChildCommentsData({required this.children, required this.totalPages});

  factory ChildCommentsData.fromJson(Map<String, dynamic> json) {
    return ChildCommentsData(
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => CommentModel.fromJson(e))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
    );
  }
}
