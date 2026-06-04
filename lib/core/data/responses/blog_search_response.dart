import 'package:teck_talk/core/data/models/user_general_model.dart';

class BlogsSearchResponse {
  final String status;
  final String message;
  final List<BlogSearchModel> data;

  BlogsSearchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BlogsSearchResponse.fromJson(Map<String, dynamic> json) {
    return BlogsSearchResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => BlogSearchModel.fromJson(e))
          .toList(),
    );
  }
}

class BlogSearchModel {
  final int id;
  final String title;
  final String subtitle;
  final String? coverImageUrl;
  final String readingTime;
  final bool isPublished;
  final bool isModified;
  final UserGeneralModel user;
  final int commentsCount;
  final int likesCount;
  final bool isLikedByUser;
  final List<BlogTagModel> tags;
  final int viewsCount;
  final bool isViewed;
  final bool isSaved;
  final String createdAt;
  final String updatedAt;

  BlogSearchModel({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogSearchModel.fromJson(Map<String, dynamic> json) {
    return BlogSearchModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      coverImageUrl: json['cover_image_url'],
      readingTime: json['reading_time'] ?? '',
      isPublished: json['is_published'] ?? false,
      isModified: json['is_modified'] ?? false,
      user: UserGeneralModel.fromJson(json['user'] ?? {}),
      commentsCount: json['comments_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      tags: (json['tags'] as List? ?? [])
          .map((e) => BlogTagModel.fromJson(e))
          .toList(),
      viewsCount: json['views_count'] ?? 0,
      isViewed: json['is_viewed'] ?? false,
      isSaved: json['is_saved'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}



class BlogTagModel {
  final int id;
  final String name;

  BlogTagModel({required this.id, required this.name});

  factory BlogTagModel.fromJson(Map<String, dynamic> json) {
    return BlogTagModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}
