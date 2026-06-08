class LikeCommentResponse {
  final String status;
  final String message;
  final CommentLikeData data;

  LikeCommentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LikeCommentResponse.fromJson(Map<String, dynamic> json) {
    return LikeCommentResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: CommentLikeData.fromJson(json['data'] ?? {}),
    );
  }
}

class CommentLikeData {
  final int likes;
  final int dislikes;
  final bool isLikedByUser;

  CommentLikeData({
    required this.likes,
    required this.dislikes,
    required this.isLikedByUser,
  });

  factory CommentLikeData.fromJson(Map<String, dynamic> json) {
    return CommentLikeData(
      likes: int.tryParse(json['likes'].toString()) ?? 0,
      dislikes: int.tryParse(json['dislikes'].toString()) ?? 0,
      isLikedByUser: json['is_liked_by_user'] ?? false,
    );
  }
}