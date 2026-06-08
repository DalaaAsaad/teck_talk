class IsLikeResponse {
  final String status;
  final String message;
  final LikeResponse data;

  IsLikeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory IsLikeResponse.fromJson(Map<String, dynamic> json) {
    return IsLikeResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: LikeResponse.fromJson(json['data'] ?? {}),
    );
  }
}

class LikeResponse {
  final bool isLiked;
  final int likesCount;

  LikeResponse({required this.isLiked, required this.likesCount});

  factory LikeResponse.fromJson(Map<String, dynamic> json) {
    return LikeResponse(
      isLiked: json['is_liked'] ?? false,
      likesCount: json['likes_count'] ?? 0,
    );
  }
}
