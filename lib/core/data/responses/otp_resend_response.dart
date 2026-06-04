class OtpResendResponse {
  final String status;
  final String message;

  OtpResendResponse({
    required this.status,
    required this.message,
  });

  factory OtpResendResponse.fromJson(Map<String, dynamic> json) {
    return OtpResendResponse(
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