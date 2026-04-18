import 'package:shared_preferences/shared_preferences.dart';
import 'package:teck_talk/main.dart';

class SharedPreferenceRepository {
  final SharedPreferences pref = prefs;
  static const String _recentSearchesKey = 'recent_searches';
  static const String _lastSearchQueryKey = 'last_search_query';

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
}
