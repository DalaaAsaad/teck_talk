class SavePostBlogResponse {
  final String status;
  final String message;
  final SavePostData data;

  SavePostBlogResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SavePostBlogResponse.fromJson(Map<String, dynamic> json) {
    return SavePostBlogResponse(
      status: json['status'],
      message: json['message'],
      data: SavePostData.fromJson(json['data']),
    );
  }
}

class SavePostData {
  final bool saved;
  final String kind;
  final String savedAt;

  SavePostData({
    required this.saved,
    required this.kind,
    required this.savedAt,
  });

  factory SavePostData.fromJson(Map<String, dynamic> json) {
    return SavePostData(
      saved: json['saved'],
      kind: json['kind'],
      savedAt: json['saved_at'],
    );
  }
}