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
      status: json['status'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ProfileData {
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

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      website: json['website'],
      location: json['location'],
      socialLinks: json['social_links'] ?? [],
      coverImageUrl: json['cover_image_url'],
      rankingPoints: json['ranking_points'],
      badge: json['badge'],
      postsCount: json['posts_count'],
      blogsCount: json['blogs_count'],
      viewsCount: json['views_count'],
      isViewed: json['is_viewed'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      isFollowing: json['is_following'],
      joinedAt: json['joined_at'],
      lastSeenAt: json['last_seen_at'],
      tags: json['tags'] ?? [],
    );
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