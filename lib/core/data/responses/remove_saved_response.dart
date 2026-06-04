class RemoveSavedResponse {
  final String status;
  final String message;

  RemoveSavedResponse({
    required this.status,
    required this.message,
  });

  factory RemoveSavedResponse.fromJson(Map<String, dynamic> json) {
    return RemoveSavedResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}