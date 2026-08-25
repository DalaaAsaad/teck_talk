class PostInfoResponse {
  final String? status;
  final String? message;
  final PostDetailsData? data;

  PostInfoResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PostInfoResponse.fromJson(Map<String, dynamic> json) {
    return PostInfoResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? PostDetailsData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class PostDetailsData {
  final int? id;
  final String? title;
  final String? body;
  final String? code;
  final String? codeLanguage;
  final String? photoUrl;
  final List<PostPhoto>? photos;
  final String? type;
  final bool? isPublished;
  final bool? isModified;
  final PostUser? user;
  final int? commentsCount;
  final int? likesCount;
  final int? viewsCount;
  final bool? isViewed;
  final bool? isLikedByUser;
  final List<PostTag>? tags;
  final String? createdAt;
  final String? updatedAt;

  PostDetailsData({
    this.id,
    this.title,
    this.body,
    this.code,
    this.codeLanguage,
    this.photoUrl,
    this.photos,
    this.type,
    this.isPublished,
    this.isModified,
    this.user,
    this.commentsCount,
    this.likesCount,
    this.viewsCount,
    this.isViewed,
    this.isLikedByUser,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  factory PostDetailsData.fromJson(Map<String, dynamic> json) {
    return PostDetailsData(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      code: json['code'],
      codeLanguage: json['code_language'],
      photoUrl: json['photo_url'],
      photos: json['photos'] != null
          ? (json['photos'] as List)
              .map((e) => PostPhoto.fromJson(e))
              .toList()
          : [],
      type: json['type'],
      isPublished: json['is_published'],
      isModified: json['is_modified'],
      user: json['user'] != null
          ? PostUser.fromJson(json['user'])
          : null,
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      viewsCount: json['views_count'],
      isViewed: json['is_viewed'],
      isLikedByUser: json['is_liked_by_user'],
      tags: json['tags'] != null
          ? (json['tags'] as List)
              .map((e) => PostTag.fromJson(e))
              .toList()
          : [],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'code': code,
      'code_language': codeLanguage,
      'photo_url': photoUrl,
      'photos': photos?.map((e) => e.toJson()).toList(),
      'type': type,
      'is_published': isPublished,
      'is_modified': isModified,
      'user': user?.toJson(),
      'comments_count': commentsCount,
      'likes_count': likesCount,
      'views_count': viewsCount,
      'is_viewed': isViewed,
      'is_liked_by_user': isLikedByUser,
      'tags': tags?.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class PostPhoto {
  final int? id;
  final String? url;
  final int? sortOrder;

  PostPhoto({
    this.id,
    this.url,
    this.sortOrder,
  });

  factory PostPhoto.fromJson(Map<String, dynamic> json) {
    return PostPhoto(
      id: json['id'],
      url: json['url'],
      sortOrder: json['sort_order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'sort_order': sortOrder,
    };
  }
}

class PostUser {
  final int? id;
  final String? username;
  final String? name;
  final String? avatarUrl;
  final String? bio;
  final String? badge;

  PostUser({
    this.id,
    this.username,
    this.name,
    this.avatarUrl,
    this.bio,
    this.badge,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      badge: json['badge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'avatar_url': avatarUrl,
      'bio': bio,
      'badge': badge,
    };
  }
}

class PostTag {
  final int? id;
  final String? name;

  PostTag({
    this.id,
    this.name,
  });

  factory PostTag.fromJson(Map<String, dynamic> json) {
    return PostTag(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}