class AppSettings {
  final String language;

  final String themeMode;

  final bool notificationsEnabled;

  const AppSettings({
    required this.language,
    required this.themeMode,
    required this.notificationsEnabled,
  });

  factory AppSettings.initial() {
    return const AppSettings(
      language: "en",
      themeMode: "system",
      notificationsEnabled: true,
    );
  }

  AppSettings copyWith({
    String? language,
    String? themeMode,
    bool? notificationsEnabled,
  }) {
    return AppSettings(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled:
          notificationsEnabled ??
          this.notificationsEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "language": language,
      "themeMode": themeMode,
      "notificationsEnabled":
          notificationsEnabled,
    };
  }

  factory AppSettings.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppSettings(
      language: map["language"] ?? "en",
      themeMode:
          map["themeMode"] ?? "system",
      notificationsEnabled:
          map["notificationsEnabled"] ??
              true,
    );
  }
}