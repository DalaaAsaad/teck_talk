class VerifyOtpModel {
  final String status;
  final String message;
  final VerifyOtpData data;

  VerifyOtpModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      status: json['status'],
      message: json['message'],
      data: VerifyOtpData.fromJson(json['data']),
    );
  }
}

class VerifyOtpData {
  final UserVerifyResponse user;
  final String accessToken;
  final String tokenType;

  VerifyOtpData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      user: UserVerifyResponse.fromJson(json['user']),
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class UserVerifyResponse {
  final int id;
  final String name;
  final String username;
  final String? phone;
  final String email;
  final String? pendingEmail;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final int followersCount;
  final int followingCount;
  final int publishedPostsCount;
  final int publishedBlogsCount;

  UserVerifyResponse({
    required this.id,
    required this.name,
    required this.username,
    this.phone,
    required this.email,
    this.pendingEmail,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.followersCount,
    required this.followingCount,
    required this.publishedPostsCount,
    required this.publishedBlogsCount,
  });

  factory UserVerifyResponse.fromJson(Map<String, dynamic> json) {
    return UserVerifyResponse(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      pendingEmail: json['pending_email'],
      emailVerifiedAt: json['email_verified_at'],
      phoneVerifiedAt: json['phone_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      publishedPostsCount: json['published_posts_count'],
      publishedBlogsCount: json['published_blogs_count'],
    );
  }
}
