import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/store_settings.dart';

class StoreSettingsLocalDataSource {
  static const _key = "store_settings";

  Future<StoreSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_key);

    if (json == null) {
      return StoreSettings.empty();
    }

    return StoreSettings.fromMap(
      jsonDecode(json),
    );
  }

  Future<void> saveSettings(
    StoreSettings settings,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _key,
      jsonEncode(
        settings.toMap(),
      ),
    );
  }
}