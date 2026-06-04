class UserGeneralModel {
  final int id;
  final String username;
  final String name;
  final String avatarUrl;
  final String badge;

  UserGeneralModel({
    required this.id,
    required this.username,
    required this.name,
    required this.avatarUrl,
    required this.badge,
  });

  factory UserGeneralModel.fromJson(Map<String, dynamic> json) {
    return UserGeneralModel(
      id: json['id'] ?? 0,
      username: _readString(json['username']),
      name: _readString(json['name']),
      avatarUrl: _readString(json['avatar_url']),
      badge: _readString(json['badge']),
    );
  }

  static String _readString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is Map<String, dynamic>) {
      for (final key in const [
        'username',
        'name',
        'avatar_url',
        'url',
        'path',
        'value',
        'title',
        'label',
      ]) {
        final candidate = value[key];
        if (candidate != null) {
          final asString = _readString(candidate);
          if (asString.isNotEmpty) return asString;
        }
      }
    }
    return value.toString();
  }
}
