import 'package:tech_talk/core/data/models/post_model.dart';

class PostsSearchResponse {
  final String status;
  final String message;
  final List<PostModel> data;

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
          .map((e) => PostModel.fromJson(e))
          .toList(),
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