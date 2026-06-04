class SignOutResponse {
  final String status;
  final String message;

  SignOutResponse({
    required this.status,
    required this.message,
  });

  factory SignOutResponse.fromJson(Map<String, dynamic> json) {
    return SignOutResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}