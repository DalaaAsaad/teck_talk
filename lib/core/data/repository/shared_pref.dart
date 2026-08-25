import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_talk/main.dart';

class SharedPreferenceRepository {
  final SharedPreferences pref = prefs;
  static const String _recentSearchesKey = 'recent_searches';
  static const String _lastSearchQueryKey = 'last_search_query';
  static const String _userFullNameKey = 'user_full_name';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userIdKey = 'user_id';
  static const String _isUserVerifiedKey = 'is_user_verified';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _authTokenKey = 'auth_token';
  static const String _badge = 'badge';
  static const String _userAvatarUrlKey = 'user_avatar_url';
  static const String _userCoverImageUrlKey = 'user_cover_image_url';

  Future<void> saveRecentSearches(List<String> searches) async {
    await pref.setStringList(_recentSearchesKey, searches);
  }

  Future<List<String>> getRecentSearches() async {
    return pref.getStringList(_recentSearchesKey) ?? [];
  }

  Future<void> clearRecentSearches() async {
    await pref.remove(_recentSearchesKey);
  }

  Future<void> saveLastSearchQuery(String query) async {
    await pref.setString(_lastSearchQueryKey, query);
  }

  Future<String> getLastSearchQuery() async {
    return pref.getString(_lastSearchQueryKey) ?? '';
  }

  Future<void> clearLastSearchQuery() async {
    await pref.remove(_lastSearchQueryKey);
  }

  Future<void> saveVerifiedUser({
    required String fullName,
    required String userName,
    required String email,
    required int userId,
  }) async {
    await pref.setString(_userFullNameKey, fullName);
    await pref.setString(_userNameKey, userName);
    await pref.setString(_userEmailKey, email);
    await pref.setInt(_userIdKey, userId);
    await pref.setBool(_isUserVerifiedKey, true);
    await pref.setBool(_isLoggedInKey, true);
  }

  Future<void> setLoggedIn(bool value) async {
    await pref.setBool(_isLoggedInKey, value);
  }

  Future<void> saveAuthToken(String token) async {
    await pref.setString(_authTokenKey, token);
  }

  Future<void> saveBadge(String badge) async {
    await pref.setString(_badge, badge);
  }

  Future<void> saveUserImages({
    String? avatarUrl,
    String? coverImageUrl,
  }) async {
    if (avatarUrl == null || avatarUrl.isEmpty) {
      await pref.remove(_userAvatarUrlKey);
    } else {
      await pref.setString(_userAvatarUrlKey, avatarUrl);
    }

    if (coverImageUrl == null || coverImageUrl.isEmpty) {
      await pref.remove(_userCoverImageUrlKey);
    } else {
      await pref.setString(_userCoverImageUrlKey, coverImageUrl);
    }
  }

  String? getUserAvatarUrl() {
    return pref.getString(_userAvatarUrlKey);
  }

  String? getUserCoverImageUrl() {
    return pref.getString(_userCoverImageUrlKey);
  }

  String? getAuthToken() {
    return pref.getString(_authTokenKey);
  }

  String? getUserEmail() {
    return pref.getString(_userEmailKey);
  }

  String? getUserFullName() {
    return pref.getString(_userFullNameKey);
  }

  String? getUserUserName() {
    return pref.getString(_userNameKey);
  }

  int? getUserId() {
    return pref.getInt(_userIdKey);
  }

  String? getBadge() {
    return pref.getString(_badge);
  }

  bool isLoggedIn() {
    return pref.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clearUserData() async {
    await pref.remove(_userFullNameKey);
    await pref.remove(_userNameKey);
    await pref.remove(_userEmailKey);
    await pref.remove(_userIdKey);
    await pref.remove(_isUserVerifiedKey);
    await pref.remove(_isLoggedInKey);
    await pref.remove(_authTokenKey);
    await pref.remove(_badge);
    await pref.remove(_userAvatarUrlKey);
    await pref.remove(_userCoverImageUrlKey);
  }
}
