class SuggestionsFolowedResponse {
  final String status;
  final String message;
  final List<SuggestedUser> data;

  SuggestionsFolowedResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SuggestionsFolowedResponse.fromJson(Map<String, dynamic> json) {
    return SuggestionsFolowedResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<SuggestedUser>.from(
              json['data'].map(
                (item) => SuggestedUser.fromJson(item),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class SuggestedUser {
  final int id;
  final String name;
  final String username;
  final String? avatar;

  SuggestedUser({
    required this.id,
    required this.name,
    required this.username,
    this.avatar,
  });

  factory SuggestedUser.fromJson(Map<String, dynamic> json) {
    return SuggestedUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'avatar': avatar,
    };
  }
}