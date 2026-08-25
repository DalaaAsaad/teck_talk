import 'package:tech_talk/core/data/models/post_model.dart';

class CreatePostResponse {
  final String status;
  final String message;
  final PostModel data;

  CreatePostResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) {
    return CreatePostResponse(
      status: json['status'],
      message: json['message'],
      data: PostModel.fromJson(json['data']),
    );
  }
}
