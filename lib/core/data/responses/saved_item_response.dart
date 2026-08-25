import 'package:tech_talk/core/data/models/pagination_model.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/models/user_general_model.dart';

class SavedItemsResponse {
  final String status;
  final String message;
  final List<SavedItem> data;
  final PaginationModel pagination;

  SavedItemsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory SavedItemsResponse.fromJson(Map<String, dynamic> json) {
    return SavedItemsResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => SavedItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : PaginationModel.fromJson(const {}),
    );
  }
}

class SavedItem {
  final String kind;
  final String savedAt;
  final dynamic data;

  SavedItem({required this.kind, required this.savedAt, required this.data});

  factory SavedItem.fromJson(Map<String, dynamic> json) {
    final kind = json['kind']?.toString() ?? '';
    final rawData = json['data'] as Map<String, dynamic>? ?? {};

    return SavedItem(
      kind: kind,
      savedAt: json['saved_at']?.toString() ?? '',
      data: kind == 'blog'
          ? BlogListSavedModel.fromJson(rawData)
          : PostModel.fromJson(rawData),
    );
  }
}

class BlogListSavedModel {
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
  final int viewsCount;
  final bool isViewed;
  final bool isSaved;
  final String createdAt;
  final String updatedAt;

  BlogListSavedModel({
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
    required this.viewsCount,
    required this.isViewed,
    required this.isSaved,
    required this.createdAt,
    required this.updatedAt,
  });

  /// كل حقل هون محمي بقيمة افتراضية - نفس أسلوب PostModel، حتى الموديل
  /// ما ينكسر لو أي حقل رجع null من السيرفر (زي reading_time لمقالة
  /// مسودة مثلاً).
  factory BlogListSavedModel.fromJson(Map<String, dynamic> json) {
    return BlogListSavedModel(
      id: _readInt(json['id']),
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      coverImageUrl: json['cover_image_url']?.toString(),
      readingTime: json['reading_time']?.toString() ?? '',
      isPublished: json['is_published'] == true,
      isModified: json['is_modified'] == true,
      user: json['user'] != null
          ? UserGeneralModel.fromJson(json['user'])
          : UserGeneralModel.fromJson(const {}),
      commentsCount: _readInt(json['comments_count']),
      likesCount: _readInt(json['likes_count']),
      isLikedByUser: json['is_liked_by_user'] == true,
      viewsCount: _readInt(json['views_count']),
      isViewed: json['is_viewed'] == true,
      isSaved: json['is_saved'] == true,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  static int _readInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}