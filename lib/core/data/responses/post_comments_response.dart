import 'package:tech_talk/core/data/models/pagination_model.dart';

class PostCommentsResponse {
  final String status;
  final String message;
  final List<CommentModel> data;
  final PaginationModel? pagination;

  PostCommentsResponse({
    required this.status,
    required this.message,
    required this.data,
    this.pagination,
  });

  factory PostCommentsResponse.fromJson(Map<String, dynamic> json) {
    return PostCommentsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => CommentModel.fromJson(e))
          .toList(),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }
}

class CommentModel {
  final int id;
  final String body;
  final String type;
  final String? code;
  final String? codeLanguage;
  final String? codeLabel;
  final int? parentId;
  final bool hasChildrens;
  final int userId;
  final int? postId;
  final int? blogId;
  String likesCount;
  String dislikesCount;
  final bool isModified;
  final bool isHighlighted;
  bool isLikedByUser;
  bool isDislikedByUser;
  final String userName;
  final String avatarUrl;
  final List<dynamic> mentions;
  final String createdAt;
  final String updatedAt;

  CommentModel({
    required this.id,
    required this.body,
    required this.type,
    this.code,
    this.codeLanguage,
    this.codeLabel,
    this.parentId,
    required this.hasChildrens,
    required this.userId,
    this.postId,
    this.blogId,
    required this.likesCount,
    required this.dislikesCount,
    required this.isModified,
    required this.isHighlighted,
    required this.isLikedByUser,
    required this.isDislikedByUser,
    required this.userName,
    required this.avatarUrl,
    required this.mentions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      code: json['code'],
      codeLanguage: json['code_language'],
      codeLabel: json['code_label'],
      parentId: json['parent_id'],
      hasChildrens: json['has_childrens'] ?? false,
      userId: json['user_id'],
      postId: json['post_id'],
      blogId: json['blog_id'],
      likesCount: json['likes_count'].toString(),
      dislikesCount: json['dislikes_count'].toString(),
      isModified: json['is_modified'] ?? false,
      isHighlighted: json['is_highlighted'] ?? false,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      isDislikedByUser: json['is_disliked_by_user'] ?? false,
      userName: json['user_name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      mentions: json['mentions'] ?? [],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
