class UsernameUpdateResponse {
  final String status;
  final String message;
  final ProfileUpdateData data;

  UsernameUpdateResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UsernameUpdateResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];

    return UsernameUpdateResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: ProfileUpdateData.fromJson(
        dataJson is Map<String, dynamic> ? dataJson : {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class ProfileUpdateData {
  final int id;
  final String username;
  final String name;
  final String avatarUrl;
  final String bio;
  final String badge;

  ProfileUpdateData({
    required this.id,
    required this.username,
    required this.name,
    required this.avatarUrl,
    required this.bio,
    required this.badge,
  });

  factory ProfileUpdateData.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateData(
      id: json['id'] ?? 0,
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      badge: json['badge']?.toString() ?? '',
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
