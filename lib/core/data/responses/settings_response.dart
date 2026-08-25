class SettingsResponse {
  final String status;
  final String message;
  final SettingsObject settings;

  SettingsResponse({
    required this.status,
    required this.message,
    required this.settings,
  });

  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      settings: SettingsObject.fromJson(json['data']?['settings'] ?? {}),
    );
  }
}

class SettingsObject {
  String theme;
  String language;
  NotificationsSettings notifications;
  PrivacySettings privacy;

  SettingsObject({
    required this.theme,
    required this.language,
    required this.notifications,
    required this.privacy,
  });

  factory SettingsObject.fromJson(Map<String, dynamic> json) {
    return SettingsObject(
      theme: json['theme'] ?? 'system',
      language: json['language'] ?? 'en',
      notifications: NotificationsSettings.fromJson(
        json['notifications'] ?? {},
      ),
      privacy: PrivacySettings.fromJson(json['privacy'] ?? {}),
    );
  }
}

class NotificationsSettings {
  NotificationChannels channels;
  NotificationEvents events;

  NotificationsSettings({required this.channels, required this.events});

  factory NotificationsSettings.fromJson(Map<String, dynamic> json) {
    return NotificationsSettings(
      channels: NotificationChannels.fromJson(json['channels'] ?? {}),
      events: NotificationEvents.fromJson(json['events'] ?? {}),
    );
  }
}

class NotificationChannels {
  bool inApp;
  bool push;
  bool email;

  NotificationChannels({
    required this.inApp,
    required this.push,
    required this.email,
  });

  factory NotificationChannels.fromJson(Map<String, dynamic> json) {
    return NotificationChannels(
      inApp: json['in_app'] ?? true,
      push: json['push'] ?? false,
      email: json['email'] ?? false,
    );
  }
}

class NotificationEvents {
  bool likes;
  bool comments;
  bool follows;
  bool mentions;
  bool highlights;
  bool verification;
  bool productUpdates;

  NotificationEvents({
    required this.likes,
    required this.comments,
    required this.follows,
    required this.mentions,
    required this.highlights,
    required this.verification,
    required this.productUpdates,
  });

  factory NotificationEvents.fromJson(Map<String, dynamic> json) {
    return NotificationEvents(
      likes: json['likes'] ?? true,
      comments: json['comments'] ?? true,
      follows: json['follows'] ?? true,
      mentions: json['mentions'] ?? true,
      highlights: json['highlights'] ?? true,
      verification: json['verification'] ?? true,
      productUpdates: json['product_updates'] ?? false,
    );
  }
}

class PrivacySettings {
  bool showEmail;
  bool profileDiscoverable;
  bool allowFollows;
  bool policyAccepted;
  String? policyVersion;

  PrivacySettings({
    required this.showEmail,
    required this.profileDiscoverable,
    required this.allowFollows,
    required this.policyAccepted,
    this.policyVersion,
  });

  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      showEmail: json['show_email'] ?? false,
      profileDiscoverable: json['profile_discoverable'] ?? true,
      allowFollows: json['allow_follows'] ?? true,
      policyAccepted: json['policy_accepted'] ?? false,
      policyVersion: json['policy_version'],
    );
  }
}
