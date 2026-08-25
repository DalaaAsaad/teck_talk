class HighlightCommentResponse {
  final String status;
  final String message;
  final HighlightedComment data;

  HighlightCommentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HighlightCommentResponse.fromJson(Map<String, dynamic> json) {
    return HighlightCommentResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: HighlightedComment.fromJson(json['data'] ?? {}),
    );
  }
}

class HighlightedComment {
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
  final int likesCount;
  final int dislikesCount;
  final bool isModified;
  bool isHighlighted;
  final bool isLikedByUser;
  final bool isDislikedByUser;
  final String userName;
  final String? avatarUrl;
  final List<dynamic> mentions;
  final String createdAt;
  final String updatedAt;

  HighlightedComment({
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
    this.avatarUrl,
    required this.mentions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HighlightedComment.fromJson(Map<String, dynamic> json) {
    return HighlightedComment(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      code: json['code'],
      codeLanguage: json['code_language'],
      codeLabel: json['code_label'],
      parentId: json['parent_id'],
      hasChildrens: json['has_childrens'] ?? false,
      userId: json['user_id'] ?? 0,
      postId: json['post_id'],
      blogId: json['blog_id'],
      likesCount: json['likes_count'] ?? 0,
      dislikesCount: json['dislikes_count'] ?? 0,
      isModified: json['is_modified'] ?? false,
      isHighlighted: json['is_highlighted'] ?? false,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      isDislikedByUser: json['is_disliked_by_user'] ?? false,
      userName: json['user_name'] ?? '',
      avatarUrl: json['avatar_url'],
      mentions: json['mentions'] ?? [],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
