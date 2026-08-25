class UpdatePostResponse {
  final String status;
  final String message;
  final PostData data;

  UpdatePostResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdatePostResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePostResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: PostData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class PostData {
  final int id;
  final String title;
  final String body;
  final String? code;
  final String? codeLanguage;
  final String? photoUrl;

  final List<PostPhoto> photos;

  final String type;
  final bool isPublished;
  final bool isModified;

  final PostUser user;

  final int commentsCount;
  final int likesCount;
  final int viewsCount;

  final bool isViewed;
  final bool isLikedByUser;

  final List<PostTag> tags;

  final String createdAt;
  final String updatedAt;

  PostData({
    required this.id,
    required this.title,
    required this.body,
    this.code,
    this.codeLanguage,
    this.photoUrl,
    required this.photos,
    required this.type,
    required this.isPublished,
    required this.isModified,
    required this.user,
    required this.commentsCount,
    required this.likesCount,
    required this.viewsCount,
    required this.isViewed,
    required this.isLikedByUser,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      code: json['code'],
      codeLanguage: json['code_language'],
      photoUrl: json['photo_url'],
      photos: (json['photos'] as List<dynamic>? ?? [])
          .map((e) => PostPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] ?? '',
      isPublished: json['is_published'] ?? false,
      isModified: json['is_modified'] ?? false,
      user: PostUser.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      commentsCount: json['comments_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      isViewed: json['is_viewed'] ?? false,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => PostTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class PostPhoto {
  final int id;
  final String url;
  final int sortOrder;

  PostPhoto({required this.id, required this.url, required this.sortOrder});

  factory PostPhoto.fromJson(Map<String, dynamic> json) {
    return PostPhoto(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      sortOrder: json['sort_order'] ?? 0,
    );
  }
}

class PostUser {
  final int id;
  final String username;
  final String name;
  final String? avatarUrl;
  final String? bio;
  final String? badge;

  PostUser({
    required this.id,
    required this.username,
    required this.name,
    this.avatarUrl,
    this.bio,
    this.badge,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      badge: json['badge'],
    );
  }
}

class PostTag {
  final int id;
  final String name;

  PostTag({required this.id, required this.name});

  factory PostTag.fromJson(Map<String, dynamic> json) {
    return PostTag(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}