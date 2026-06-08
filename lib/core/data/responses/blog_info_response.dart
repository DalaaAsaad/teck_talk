import 'package:tech_talk/core/data/models/user_general_model.dart';

class BlogInfoResponse {
  final String status;
  final String message;
  final BlogInfoData data;

  BlogInfoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BlogInfoResponse.fromJson(Map<String, dynamic> json) {
    return BlogInfoResponse(
      status: json['status'],
      message: json['message'],
      data: BlogInfoData.fromJson(json['data']),
    );
  }
}

class BlogInfoData {
  final int id;
  final String title;
  final String subtitle;
  final String? coverImageUrl;
  final String? readingTime;
  final bool isPublished;
  final bool isModified;
  final UserGeneralModel user;
  final int commentsCount;
  int likesCount;
  bool isLikedByUser;
  final List<Tag> tags;
  final int viewsCount;
  final bool isViewed;
  bool isSaved;
  final List<Section> sections;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogInfoData({
    required this.id,
    required this.title,
    required this.subtitle,
    this.coverImageUrl,
    this.readingTime,
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogInfoData.fromJson(Map<String, dynamic> json) {
    return BlogInfoData(
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
      tags: (json['tags'] as List).map((e) => Tag.fromJson(e)).toList(),
      viewsCount: json['views_count'],
      isViewed: json['is_viewed'],
      isSaved: json['is_saved'],
      sections: (json['sections'] as List)
          .map((e) => Section.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Tag {
  final int id;
  final String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'], name: json['name']);
  }
}

class Section {
  final int id;
  final String title;
  final String content;
  final String order;
  final String? imageUrl;

  Section({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
    this.imageUrl,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      order: json['order'],
      imageUrl: json['image_url'],
    );
  }
}
