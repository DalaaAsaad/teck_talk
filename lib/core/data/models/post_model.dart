import 'package:tech_talk/core/data/models/user_general_model.dart';

class PostSavedModel {
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

  PostSavedModel({
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

  factory PostSavedModel.fromJson(Map<String, dynamic> json) {
    return PostSavedModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      code: json['code'],
      codeLanguage: json['code_language'],
      photoUrl: json['photo_url'],
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e))
              .toList() ??
          [],
      type: json['type'],
      isPublished: json['is_published'],
      isModified: json['is_modified'],
      user: UserGeneralModel.fromJson(json['user']),
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      viewsCount: json['views_count'],
      isViewed: json['is_viewed'],
      isSaved: json['is_saved'],
      isLikedByUser: json['is_liked_by_user'],
      tags: _readTags(json['tags']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  static List<TagModel> _readTags(dynamic value) {
    try {
      if (value == null) return <TagModel>[];
      if (value is List) {
        return value.map((e) {
          try {
            return TagModel.fromJson(e);
          } catch (_) {
            // if tag is a plain string
            if (e is String) return TagModel(id: 0, name: e);
            return TagModel(id: 0, name: e.toString());
          }
        }).toList();
      }
      // if server sends a single tag as string or map
      if (value is String) return [TagModel(id: 0, name: value)];
      if (value is Map)
        return [TagModel.fromJson(Map<String, dynamic>.from(value))];
    } catch (_) {}
    return <TagModel>[];
  }
}

class TagModel {
  final int id;
  final String name;

  TagModel({required this.id, required this.name});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(id: json['id'], name: json['name']);
  }
}

class Photo {
  final int id;
  final String url;
  final int sortOrder;

  Photo({required this.id, required this.url, required this.sortOrder});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
      sortOrder: json['sort_order'],
    );
  }
}
