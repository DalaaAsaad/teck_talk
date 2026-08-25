class UpdateNameResponse {
  final String status;
  final String message;
  final UpdateNameData data;

  UpdateNameResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateNameResponse.fromJson(Map<String, dynamic> json) {
    return UpdateNameResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: UpdateNameData.fromJson(json['data'] ?? {}),
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

class UpdateNameData {
  final String name;

  UpdateNameData({
    required this.name,
  });

  factory UpdateNameData.fromJson(Map<String, dynamic> json) {
    return UpdateNameData(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}