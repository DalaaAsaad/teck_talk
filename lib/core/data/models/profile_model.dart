class ProfileModel {
  final int id;
  final int userId;
  final String? avatar;
  final String? bio;
  final String? website;
  final String? location;
  final dynamic socialLinks;
  final String? coverImage;
  final dynamic settings;
  final int rankingPoints;
  final String? lastSeenAt;
  final String createdAt;
  final String updatedAt;
  final int viewsCount;

  ProfileModel({
    required this.id,
    required this.userId,
    this.avatar,
    this.bio,
    this.website,
    this.location,
    this.socialLinks,
    this.coverImage,
    this.settings,
    required this.rankingPoints,
    this.lastSeenAt,
    required this.createdAt,
    required this.updatedAt,
    required this.viewsCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      userId: int.parse(json['user_id'].toString()),
      avatar: json['avatar'],
      bio: json['bio'],
      website: json['website'],
      location: json['location'],
      socialLinks: json['social_links'],
      coverImage: json['cover_image'],
      settings: json['settings'],
      rankingPoints: json['ranking_points'] ?? 0,
      lastSeenAt: json['last_seen_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      viewsCount: json['views_count'] ?? 0,
    );
  }
}