
import 'package:tech_talk/core/data/models/pagination_model.dart';
import 'package:tech_talk/core/data/models/user_general_model.dart';

class BlogsResponse {
  final String status;
  final String message;
  final List<BlogModel> data;
  final PaginationModel pagination;

  BlogsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory BlogsResponse.fromJson(Map<String, dynamic> json) {
    return BlogsResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: _readList(
        json['data'],
      ).whereType<Map<String, dynamic>>().map(BlogModel.fromJson).toList(),
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }

  static List<dynamic> _readList(dynamic value) {
    if (value is List) return value;
    if (value is Iterable) return value.toList();
    return <dynamic>[];
  }
}

class BlogModel {
  final int id;
  final String title;
  final String subtitle;
  final String? coverImageUrl;
  final String readingTime;
  final bool isPublished;
  final bool isModified;
  bool isLikedByUser;
  bool isViewed;
  bool isSaved;
  int likesCount;
  int commentsCount;
  int viewsCount;
  final String createdAt;
  final String updatedAt;
  final UserGeneralModel user;

  BlogModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coverImageUrl,
    required this.readingTime,
    required this.isPublished,
    required this.isModified,
    required this.isLikedByUser,
    required this.isViewed,
    required this.isSaved,
    required this.likesCount,
    required this.commentsCount,
    required this.viewsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      coverImageUrl: json['cover_image_url']?.toString(),
      readingTime: json['reading_time']?.toString() ?? '',
      isPublished: json['is_published'] ?? false,
      isModified: json['is_modified'] ?? false,
      isLikedByUser: json['is_liked_by_user'] ?? false,
      isViewed: json['is_viewed'] ?? false,
      isSaved: json['is_saved'] ?? false,
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      user: UserGeneralModel.fromJson(_readMap(json['user'])),
    );
  }

  static Map<String, dynamic> _readMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }
}
