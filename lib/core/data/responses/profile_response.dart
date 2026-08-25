class ProfileResponse {
  final String status;
  final String message;
  final ProfileData data;

  ProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class ProfileData {
  final String? id;
  final String username;
  final String name;
  final String email;
  final String avatarUrl;
  final String? bio;
  final String? website;
  final String? location;
  final List<dynamic> socialLinks;
  final String? coverImageUrl;
  final int rankingPoints;
  final String badge;
  final int postsCount;
  final int blogsCount;
  final int viewsCount;
  final bool isViewed;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;
  final String joinedAt;
  final String? lastSeenAt;
  final List<dynamic> tags;

  ProfileData({
    required this.username,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.bio,
    this.website,
    this.location,
    this.id,
    required this.socialLinks,
    this.coverImageUrl,
    required this.rankingPoints,
    required this.badge,
    required this.postsCount,
    required this.blogsCount,
    required this.viewsCount,
    required this.isViewed,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
    required this.joinedAt,
    this.lastSeenAt,
    required this.tags,
  });

  /// كل حقل هون محمي بقيمة افتراضية - نفس أسلوب PostModel/BlogListSavedModel.
  /// أهم نقطة: avatarUrl/coverImageUrl/badge ممكن يرجعوا null لمستخدم
  /// جديد لسا ما كمّل بروفايله، وهاد كان سبب الـ TypeError.
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id']?.toString(),
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
      bio: json['bio']?.toString(),
      website: json['website']?.toString(),
      location: json['location']?.toString(),
      socialLinks: (json['social_links'] as List<dynamic>?) ?? [],
      coverImageUrl: json['cover_image_url']?.toString(),
      rankingPoints: _readInt(json['ranking_points']),
      badge: json['badge']?.toString() ?? '',
      postsCount: _readInt(json['posts_count']),
      blogsCount: _readInt(json['blogs_count']),
      viewsCount: _readInt(json['views_count']),
      isViewed: json['is_viewed'] == true,
      followersCount: _readInt(json['followers_count']),
      followingCount: _readInt(json['following_count']),
      isFollowing: json['is_following'] == true,
      joinedAt: json['joined_at']?.toString() ?? '',
      lastSeenAt: json['last_seen_at']?.toString(),
      tags: (json['tags'] as List<dynamic>?) ?? [],
    );
  }

  static int _readInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'bio': bio,
      'website': website,
      'location': location,
      'social_links': socialLinks,
      'cover_image_url': coverImageUrl,
      'ranking_points': rankingPoints,
      'badge': badge,
      'posts_count': postsCount,
      'blogs_count': blogsCount,
      'views_count': viewsCount,
      'is_viewed': isViewed,
      'followers_count': followersCount,
      'following_count': followingCount,
      'is_following': isFollowing,
      'joined_at': joinedAt,
      'last_seen_at': lastSeenAt,
      'tags': tags,
    };
  }
}
