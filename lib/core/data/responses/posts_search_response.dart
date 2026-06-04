class PostsSearchResponse {
  final String status;
  final String message;
  final List<PostSearchModel> data;

  PostsSearchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PostsSearchResponse.fromJson(Map<String, dynamic> json) {
    return PostsSearchResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => PostSearchModel.fromJson(e))
          .toList(),
    );
  }
}

class PostSearchModel {
  final int id;
  final String title;
  final String body;
  final String? code;
  final String? codeLanguage;
  final String? photoUrl;
  final List<PostPhotoModel> photos;
  final String type;
  final bool isPublished;
  final bool isModified;
  final UserSearchModel user;
  final int commentsCount;
  final int likesCount;
  final int viewsCount;
  final bool isViewed;
  final bool isSaved;
  final bool isLikedByUser;
  final List<TagSearchModel> tags;
  final String createdAt;
  final String updatedAt;

  PostSearchModel({
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
    required this.isSaved,
    required this.isLikedByUser,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostSearchModel.fromJson(Map<String, dynamic> json) {
    return PostSearchModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      code: json['code'],
      codeLanguage: json['code_language'],
      photoUrl: json['photo_url'],
      photos: (json['photos'] as List? ?? [])
          .map((e) => PostPhotoModel.fromJson(e))
          .toList(),
      type: json['type'] ?? '',
      isPublished: json['is_published'] ?? false,
      isModified: json['is_modified'] ?? false,
      user: UserSearchModel.fromJson(json['user'] ?? {}),
      commentsCount: json['comments_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      isViewed: json['is_viewed'] ?? false,
      isSaved: json['is_saved'] ?? false,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      tags: (json['tags'] as List? ?? [])
          .map((e) => TagSearchModel.fromJson(e))
          .toList(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class PostPhotoModel {
  final int id;
  final String url;
  final String? sortOrder;

  PostPhotoModel({
    required this.id,
    required this.url,
    this.sortOrder,
  });

  factory PostPhotoModel.fromJson(Map<String, dynamic> json) {
    return PostPhotoModel(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      sortOrder: json['sort_order']?.toString(),
    );
  }
}

class UserSearchModel {
  final int id;
  final String username;
  final String name;
  final String avatarUrl;
  final String badge;

  UserSearchModel({
    required this.id,
    required this.username,
    required this.name,
    required this.avatarUrl,
    required this.badge,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      badge: json['badge'] ?? '',
    );
  }
}

class TagSearchModel {
  final int id;
  final String name;

  TagSearchModel({
    required this.id,
    required this.name,
  });

  factory TagSearchModel.fromJson(Map<String, dynamic> json) {
    return TagSearchModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}