
import 'package:tech_talk/core/data/models/profile_model.dart';

class SignInResponse {
  final String status;
  final String message;
  final SignInData data;

  SignInResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: SignInData.fromJson(json['data'] ?? {}),
    );
  }
}

class SignInData {
  final UserSigInModel user;
  final String accessToken;
  final String tokenType;

  SignInData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      user: UserSigInModel.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
    );
  }
}

class UserSigInModel {
  final int id;
  final String name;
  final String username;
  final String? phone;
  final String email;
  final String? pendingEmail;
  final String? emailVerifiedAt;
  final bool isAdmin;
  final String? phoneVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final int followersCount;
  final int followingCount;
  final int publishedPostsCount;
  final int publishedBlogsCount;
  final ProfileModel profile;

  UserSigInModel({
    required this.id,
    required this.name,
    required this.username,
    this.phone,
    required this.email,
    this.pendingEmail,
    this.emailVerifiedAt,
    required this.isAdmin,
    this.phoneVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.followersCount,
    required this.followingCount,
    required this.publishedPostsCount,
    required this.publishedBlogsCount,
    required this.profile,
  });

  factory UserSigInModel.fromJson(Map<String, dynamic> json) {
    return UserSigInModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'],
      email: json['email'] ?? '',
      pendingEmail: json['pending_email'],
      emailVerifiedAt: json['email_verified_at'],
      isAdmin: json['is_admin'] ?? false,
      phoneVerifiedAt: json['phone_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      publishedPostsCount: json['published_posts_count'] ?? 0,
      publishedBlogsCount: json['published_blogs_count'] ?? 0,
      profile: ProfileModel.fromJson(json['profile'] ?? {}),
    );
  }
}
