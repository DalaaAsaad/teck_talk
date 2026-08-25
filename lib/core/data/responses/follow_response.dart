class FollowResponse {
  final String status;
  final String message;
  final FollowData data;

  FollowResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FollowResponse.fromJson(Map<String, dynamic> json) {
    return FollowResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: FollowData.fromJson(json['data'] ?? {}),
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

class FollowData {
  final bool isFollowing;
  final int followersCount;

  FollowData({
    required this.isFollowing,
    required this.followersCount,
  });

  factory FollowData.fromJson(Map<String, dynamic> json) {
    return FollowData(
      isFollowing: json['is_following'] ?? false,
      followersCount: json['followers_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_following': isFollowing,
      'followers_count': followersCount,
    };
  }
}