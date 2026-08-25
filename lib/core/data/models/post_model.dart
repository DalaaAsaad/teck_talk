import 'package:tech_talk/core/data/models/user_general_model.dart';

class PostModel {
  final int id;
  final String title;
  final String body;
  final String? code;
  final String? codeLanguage;
  final String? photoUrl;
  final List<Photo> photos;
  final String type;
  final bool isPublished;
  final bool isModified;
  final UserGeneralModel user;
  final int commentsCount;
  int likesCount;
  final int viewsCount;
  final bool isViewed;
  bool isSaved;
  bool isLikedByUser;
  final List<TagModel> tags;
  final String createdAt;
  final String updatedAt;

  PostModel({
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

  /// كل حقل هون محمي بقيمة افتراضية (?? أو parsing دفاعي) - هيك الموديل
  /// ما بينكسر لو الـ response جزئي (مثلاً endpoints زي إضافة/حذف صورة
  /// ممكن ما ترجّع كل حقول البوست الكاملة زي comments_count/views_count).
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: _readInt(json['id']),
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      code: json['code']?.toString(),
      codeLanguage: json['code_language']?.toString(),
      photoUrl: json['photo_url']?.toString(),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      type: json['type']?.toString() ?? '',
      isPublished: json['is_published'] == true,
      isModified: json['is_modified'] == true,
      user: json['user'] != null
          ? UserGeneralModel.fromJson(json['user'])
          : UserGeneralModel.fromJson(const {}),
      commentsCount: _readInt(json['comments_count']),
      likesCount: _readInt(json['likes_count']),
      viewsCount: _readInt(json['views_count']),
      isViewed: json['is_viewed'] == true,
      isSaved: json['is_saved'] == true,
      isLikedByUser: json['is_liked_by_user'] == true,
      tags: _readTags(json['tags']),
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

  static List<TagModel> _readTags(dynamic value) {
    try {
      if (value == null) return <TagModel>[];
      if (value is List) {
        return value.map((e) {
          try {
            return TagModel.fromJson(Map<String, dynamic>.from(e));
          } catch (_) {
            if (e is String) return TagModel(id: 0, name: e);
            return TagModel(id: 0, name: e.toString());
          }
        }).toList();
      }
      if (value is String) return [TagModel(id: 0, name: value)];
      if (value is Map) {
        return [TagModel.fromJson(Map<String, dynamic>.from(value))];
      }
    } catch (_) {}
    return <TagModel>[];
  }
}

class TagModel {
  final int id;
  final String name;

  TagModel({required this.id, required this.name});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: PostModel._readInt(json['id']),
      name: json['name']?.toString() ?? '',
    );
  }
}

class Photo {
  final int id;
  final String url;
  final int sortOrder;

  Photo({required this.id, required this.url, required this.sortOrder});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: PostModel._readInt(json['id']),
      url: json['url']?.toString() ?? '',
      sortOrder: PostModel._readInt(json['sort_order']),
    );
  }
}
