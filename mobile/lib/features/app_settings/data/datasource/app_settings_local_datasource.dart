import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_settings.dart';

class AppSettingsLocalDataSource {
  static const _languageKey = "app_language";

  static const _themeKey = "app_theme";

  static const _notificationsKey =
      "app_notifications";

  Future<AppSettings> getSettings() async {
    final prefs =
        await SharedPreferences.getInstance();

    return AppSettings(
      language:
          prefs.getString(_languageKey) ??
              "en",
      themeMode:
          prefs.getString(_themeKey) ??
              "system",
      notificationsEnabled:
          prefs.getBool(
                _notificationsKey,
              ) ??
              true,
    );
  }

  Future<void> saveSettings(
    AppSettings settings,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      _languageKey,
      settings.language,
    );

    await prefs.setString(
      _themeKey,
      settings.themeMode,
    );

    await prefs.setBool(
      _notificationsKey,
      settings.notificationsEnabled,
    );
  }
}