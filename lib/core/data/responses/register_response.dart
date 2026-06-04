

class RegisterResponse {
  final String status;
  final String message;
  final Data data;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class Data {
  final UserBasicInfo user;
  final int userId;

  Data({required this.user, required this.userId});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: UserBasicInfo.fromJson(json['user']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'user_id': userId};
  }
}
class UserBasicInfo {
  final int id;
  final String name;
  final String email;
  final String username;
  final String createdAt;
  final String updatedAt;

  UserBasicInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserBasicInfo.fromJson(Map<String, dynamic> json) {
    return UserBasicInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
