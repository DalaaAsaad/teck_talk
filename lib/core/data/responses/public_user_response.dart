class publicUserResponse {
  final String status;
  final String message;
  final userProfileData data;

  publicUserResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory publicUserResponse.fromJson(Map<String, dynamic> json) {
    return publicUserResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: userProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class userProfileData {
  final int id;
  final String username;
  final String name;
  final String? avatarUrl;
  final String? bio;
  final String? website;
  final String? location;
  final List<dynamic> socialLinks;
  final String? coverImageUrl;
  final int rankingPoints;
  final String? badge;
  final int postsCount;
  final int blogsCount;
  final int viewsCount;
  final bool isViewed;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;
  final DateTime? joinedAt;
  final DateTime? lastSeenAt;
  final List<ProfileTag> tags;

  userProfileData({
    required this.id,
    required this.username,
    required this.name,
    this.avatarUrl,
    this.bio,
    this.website,
    this.location,
    required this.socialLinks,
    this.coverImageUrl,
    required this.rankingPoints,
    this.badge,
    required this.postsCount,
    required this.blogsCount,
    required this.viewsCount,
    required this.isViewed,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
    this.joinedAt,
    this.lastSeenAt,
    required this.tags,
  });

  factory userProfileData.fromJson(Map<String, dynamic> json) {
    return userProfileData(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      website: json['website'],
      location: json['location'],
      socialLinks: json['social_links'] ?? [],
      coverImageUrl: json['cover_image_url'],
      rankingPoints: json['ranking_points'] ?? 0,
      badge: json['badge'],
      postsCount: json['posts_count'] ?? 0,
      blogsCount: json['blogs_count'] ?? 0,
      viewsCount: json['views_count'] ?? 0,
      isViewed: json['is_viewed'] ?? false,
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      isFollowing: json['is_following'] ?? false,
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at'])
          : null,
      lastSeenAt: json['last_seen_at'] != null
          ? DateTime.tryParse(json['last_seen_at'])
          : null,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => ProfileTag.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ProfileTag {
  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProfileTagPivot? pivot;

  ProfileTag({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory ProfileTag.fromJson(Map<String, dynamic> json) {
    return ProfileTag(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      pivot: json['pivot'] != null
          ? ProfileTagPivot.fromJson(json['pivot'])
          : null,
    );
  }
}

class ProfileTagPivot {
  final int profileId;
  final int tagId;

  ProfileTagPivot({
    required this.profileId,
    required this.tagId,
  });

  factory ProfileTagPivot.fromJson(Map<String, dynamic> json) {
    return ProfileTagPivot(
      profileId: json['profile_id'] ?? 0,
      tagId: json['tag_id'] ?? 0,
    );
  }
}