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
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: BlogInfoData.fromJson(
        json['data'] as Map<String, dynamic>? ?? {},
      ),
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  /// كل حقل هون محمي بقيمة افتراضية - نفس أسلوب PostModel/ProfileData.
  /// أهم نقطة: sections/tags ممكن يرجعوا null بردود اللستة (بعكس رد
  /// تفاصيل بلوغ وحدة يلي بيرجعهم كاملين) - هيك كان سبب الـ TypeError.
  factory BlogInfoData.fromJson(Map<String, dynamic> json) {
    return BlogInfoData(
      id: _readInt(json['id']),
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      coverImageUrl: json['cover_image_url']?.toString(),
      readingTime: json['reading_time']?.toString(),
      isPublished: json['is_published'] == true,
      isModified: json['is_modified'] == true,
      user: json['user'] != null
          ? UserGeneralModel.fromJson(json['user'])
          : UserGeneralModel.fromJson(const {}),
      commentsCount: _readInt(json['comments_count']),
      likesCount: _readInt(json['likes_count']),
      isLikedByUser: json['is_liked_by_user'] == true,
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((e) => Tag.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      viewsCount: _readInt(json['views_count']),
      isViewed: json['is_viewed'] == true,
      isSaved: json['is_saved'] == true,
      sections: (json['sections'] as List<dynamic>? ?? [])
          .map((e) => Section.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  static int _readInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}

class Tag {
  final int id;
  final String name;

  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: BlogInfoData._readInt(json['id']),
      name: json['name']?.toString() ?? '',
    );
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
      id: BlogInfoData._readInt(json['id']),
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      order: json['order']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
    );
  }
}