import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/settings_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class SettingsController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  final Rxn<SettingsObject> settings = Rxn<SettingsObject>();
  final RxBool isLoading = false.obs;

  final RxSet<String> savingKeys = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final result = await _authRepository.getSettings(token: token);
      result.fold(
        (error) => AppSnackBar.error(error),
        (response) => settings.value = response.settings,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _patch({
    required String key,
    required Map<String, dynamic> body,
    required VoidCallback applyLocally,
    required VoidCallback revertLocally,
  }) async {
    if (settings.value == null) return;

    savingKeys.add(key);
    applyLocally();
    settings.refresh();

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        revertLocally();
        settings.refresh();
        return;
      }

      final result = await _authRepository.patchSettings(
        token: token,
        patch: body,
      );

      result.fold(
        (error) {
          AppSnackBar.error(error);
          revertLocally();
          settings.refresh();
        },
        (response) => settings.value = response.settings,
      );
    } catch (e) {
      AppSnackBar.error('Something went wrong');
      revertLocally();
      settings.refresh();
    } finally {
      savingKeys.remove(key);
    }
  }


  void setTheme(String value) {
    final old = settings.value!.theme;
    _patch(
      key: 'theme',
      body: {'theme': value},
      applyLocally: () => settings.value!.theme = value,
      revertLocally: () => settings.value!.theme = old,
    );
  }

  void setLanguage(String value) {
    final old = settings.value!.language;
    _patch(
      key: 'language',
      body: {'language': value},
      applyLocally: () => settings.value!.language = value,
      revertLocally: () => settings.value!.language = old,
    );
  }



  void setChannelInApp(bool value) {
    final old = settings.value!.notifications.channels.inApp;
    _patch(
      key: 'channel_in_app',
      body: {
        'notifications': {
          'channels': {'in_app': value},
        },
      },
      applyLocally: () => settings.value!.notifications.channels.inApp = value,
      revertLocally: () =>
          settings.value!.notifications.channels.inApp = old,
    );
  }

  void setChannelPush(bool value) {
    final old = settings.value!.notifications.channels.push;
    _patch(
      key: 'channel_push',
      body: {
        'notifications': {
          'channels': {'push': value},
        },
      },
      applyLocally: () => settings.value!.notifications.channels.push = value,
      revertLocally: () => settings.value!.notifications.channels.push = old,
    );
  }

  void setChannelEmail(bool value) {
    final old = settings.value!.notifications.channels.email;
    _patch(
      key: 'channel_email',
      body: {
        'notifications': {
          'channels': {'email': value},
        },
      },
      applyLocally: () => settings.value!.notifications.channels.email = value,
      revertLocally: () =>
          settings.value!.notifications.channels.email = old,
    );
  }


  void setEvent(String eventKey, bool value) {
    final events = settings.value!.notifications.events;
    final old = _getEvent(events, eventKey);
    _patch(
      key: 'event_$eventKey',
      body: {
        'notifications': {
          'events': {eventKey: value},
        },
      },
      applyLocally: () => _setEvent(events, eventKey, value),
      revertLocally: () => _setEvent(events, eventKey, old),
    );
  }

  bool _getEvent(NotificationEvents e, String key) {
    switch (key) {
      case 'likes':
        return e.likes;
      case 'comments':
        return e.comments;
      case 'follows':
        return e.follows;
      case 'mentions':
        return e.mentions;
      case 'highlights':
        return e.highlights;
      case 'verification':
        return e.verification;
      case 'product_updates':
        return e.productUpdates;
      default:
        return false;
    }
  }

  void _setEvent(NotificationEvents e, String key, bool value) {
    switch (key) {
      case 'likes':
        e.likes = value;
        break;
      case 'comments':
        e.comments = value;
        break;
      case 'follows':
        e.follows = value;
        break;
      case 'mentions':
        e.mentions = value;
        break;
      case 'highlights':
        e.highlights = value;
        break;
      case 'verification':
        e.verification = value;
        break;
      case 'product_updates':
        e.productUpdates = value;
        break;
    }
  }


  void setShowEmail(bool value) {
    final old = settings.value!.privacy.showEmail;
    _patch(
      key: 'show_email',
      body: {
        'privacy': {'show_email': value},
      },
      applyLocally: () => settings.value!.privacy.showEmail = value,
      revertLocally: () => settings.value!.privacy.showEmail = old,
    );
  }

  void setProfileDiscoverable(bool value) {
    final old = settings.value!.privacy.profileDiscoverable;
    _patch(
      key: 'profile_discoverable',
      body: {
        'privacy': {'profile_discoverable': value},
      },
      applyLocally: () => settings.value!.privacy.profileDiscoverable = value,
      revertLocally: () =>
          settings.value!.privacy.profileDiscoverable = old,
    );
  }

  void setAllowFollows(bool value) {
    final old = settings.value!.privacy.allowFollows;
    _patch(
      key: 'allow_follows',
      body: {
        'privacy': {'allow_follows': value},
      },
      applyLocally: () => settings.value!.privacy.allowFollows = value,
      revertLocally: () => settings.value!.privacy.allowFollows = old,
    );
  }
}
