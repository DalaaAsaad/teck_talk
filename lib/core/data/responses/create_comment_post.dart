import 'package:tech_talk/core/data/responses/post_comments_response.dart';

class CreateCommentPostResponse {
  final String status;
  final String message;
  final CommentModel data;

  CreateCommentPostResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateCommentPostResponse.fromJson(Map<String, dynamic> json) {
    return CreateCommentPostResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: CommentModel.fromJson(json['data'] ?? {}),
    );
  }
}
