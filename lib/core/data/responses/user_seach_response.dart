import 'package:teck_talk/core/data/models/user_general_model.dart';

class UsersSearchresponse {
  final String status;
  final String message;
  final List<UserGeneralModel> data;

  UsersSearchresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UsersSearchresponse.fromJson(Map<String, dynamic> json) {
    return UsersSearchresponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List)
          .map((e) => UserGeneralModel.fromJson(e))
          .toList(),
    );
  }
}


