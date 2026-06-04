import 'package:teck_talk/core/data/models/pagination_model.dart';
import 'package:teck_talk/core/data/models/post_model.dart';
import 'package:teck_talk/core/data/models/user_general_model.dart';

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
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => SavedItem.fromJson(e))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }
}

class SavedItem {
  final String kind;
  final String savedAt;
  final dynamic data;

  SavedItem({
    required this.kind,
    required this.savedAt,
    required this.data,
  });

  factory SavedItem.fromJson(Map<String, dynamic> json) {
    return SavedItem(
      kind: json['kind'],
      savedAt: json['saved_at'],
      data: json['kind'] == 'blog'
          ? BlogListSavedModel.fromJson(json['data'])
          : PostSavedModel.fromJson(json['data']),
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

  factory BlogListSavedModel.fromJson(Map<String, dynamic> json) {
    return BlogListSavedModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      coverImageUrl: json['cover_image_url'],
      readingTime: json['reading_time'],
      isPublished: json['is_published'],
      isModified: json['is_modified'],
      user: UserGeneralModel.fromJson(json['user']),
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      isLikedByUser: json['is_liked_by_user'],
      viewsCount: json['views_count'],
      isViewed: json['is_viewed'],
      isSaved: json['is_saved'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}