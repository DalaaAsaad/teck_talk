class CreateBlogResponse {
  final String status;
  final String message;
  final BlogData data;

  CreateBlogResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateBlogResponse.fromJson(Map<String, dynamic> json) {
    return CreateBlogResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: BlogData.fromJson(json['data'] ?? {}),
    );
  }
}

class BlogData {
  final int id;
  final String title;
  final String subtitle;
  final String? coverImageUrl;
  final String readingTime;
  final bool isPublished;
  final bool isModified;
  final BlogUser user;
  final int commentsCount;
  final int likesCount;
  final bool isLikedByUser;
  final List<BlogTag> tags;
  final int viewsCount;
  final bool isViewed;
  final bool isSaved;
  final List<BlogSection> sections;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BlogData({
    required this.id,
    required this.title,
    required this.subtitle,
    this.coverImageUrl,
    required this.readingTime,
    required this.isPublished,
    required this.isModified,
    required this.user,
    required this.commentsCount,
    required this.likesCount,
    required this.isLikedByUser,
    required this.tags,
    required this.viewsCount,
    required this.isViewed,
    required this.isSaved,
    required this.sections,
    this.createdAt,
    this.updatedAt,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      coverImageUrl: json['cover_image_url'],
      readingTime: json['reading_time'] ?? '',
      isPublished: json['is_published'] ?? false,
      isModified: json['is_modified'] ?? false,
      user: BlogUser.fromJson(json['user'] ?? {}),
      commentsCount: json['comments_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => BlogTag.fromJson(e))
              .toList() ??
          [],
      viewsCount: json['views_count'] ?? 0,
      isViewed: json['is_viewed'] ?? false,
      isSaved: json['is_saved'] ?? false,
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => BlogSection.fromJson(e))
              .toList() ??
          [],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

class BlogUser {
  final int id;
  final String username;
  final String name;
  final String? avatarUrl;
  final String? badge;

  BlogUser({
    required this.id,
    required this.username,
    required this.name,
    this.avatarUrl,
    this.badge,
  });

  factory BlogUser.fromJson(Map<String, dynamic> json) {
    return BlogUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'],
      badge: json['badge'],
    );
  }
}

class BlogTag {
  final int id;
  final String name;

  BlogTag({
    required this.id,
    required this.name,
  });

  factory BlogTag.fromJson(Map<String, dynamic> json) {
    return BlogTag(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class BlogSection {
  final int id;
  final String title;
  final String content;
  final int order;
  final String? imageUrl;

  BlogSection({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
    this.imageUrl,
  });

  factory BlogSection.fromJson(Map<String, dynamic> json) {
    return BlogSection(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      order: json['order'] ?? 0,
      imageUrl: json['image_url'],
    );
  }
}