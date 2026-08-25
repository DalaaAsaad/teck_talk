class CommentInfoResponse {
  final String? status;
  final String? message;
  final CommentData? data;

  CommentInfoResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CommentInfoResponse.fromJson(Map<String, dynamic> json) {
    return CommentInfoResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? CommentData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CommentData {
  final int? id;
  final String? body;
  final String? type;
  final String? code;
  final String? codeLanguage;
  final int? parentId;
  final bool? hasChildrens;
  final int? userId;
  final int? postId;
  final int? blogId;
  final bool? isModified;
  final bool? isHighlighted;
  final bool? isLikedByUser;
  final String? userName;
  final List<CommentMention>? mentions;
  final String? createdAt;
  final String? updatedAt;

  CommentData({
    this.id,
    this.body,
    this.type,
    this.code,
    this.codeLanguage,
    this.parentId,
    this.hasChildrens,
    this.userId,
    this.postId,
    this.blogId,
    this.isModified,
    this.isHighlighted,
    this.isLikedByUser,
    this.userName,
    this.mentions,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['id'],
      body: json['body'],
      type: json['type'],
      code: json['code'],
      codeLanguage: json['code_language'],
      parentId: json['parent_id'],
      hasChildrens: json['has_childrens'],
      userId: json['user_id'],
      postId: json['post_id'],
      blogId: json['blog_id'],
      isModified: json['is_modified'],
      isHighlighted: json['is_highlighted'],
      isLikedByUser: json['is_liked_by_user'],
      userName: json['user_name'],
      mentions: json['mentions'] != null
          ? (json['mentions'] as List)
              .map((e) => CommentMention.fromJson(e))
              .toList()
          : [],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'type': type,
      'code': code,
      'code_language': codeLanguage,
      'parent_id': parentId,
      'has_childrens': hasChildrens,
      'user_id': userId,
      'post_id': postId,
      'blog_id': blogId,
      'is_modified': isModified,
      'is_highlighted': isHighlighted,
      'is_liked_by_user': isLikedByUser,
      'user_name': userName,
      'mentions': mentions?.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class CommentMention {
  final int? id;
  final String? username;
  final String? profileUrl;

  CommentMention({
    this.id,
    this.username,
    this.profileUrl,
  });

  factory CommentMention.fromJson(Map<String, dynamic> json) {
    return CommentMention(
      id: json['id'],
      username: json['username'],
      profileUrl: json['profile_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_url': profileUrl,
    };
  }
}