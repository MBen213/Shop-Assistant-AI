import 'package:flutter/material.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/usecases/get_app_settings_usecase.dart';
import '../../domain/usecases/save_app_settings_usecase.dart';

class AppSettingsProvider extends ChangeNotifier {
  // ====================================================
  // Constructor
  // ====================================================

  AppSettingsProvider({
    required this._getSettingsUseCase,
    required this._saveSettingsUseCase,
  }) {
    loadSettings();
  }

  // ====================================================
  // Dependencies
  // ====================================================

  final GetAppSettingsUseCase _getSettingsUseCase;
  final SaveAppSettingsUseCase _saveSettingsUseCase;

  // ====================================================
  // State
  // ====================================================

  bool _isLoading = false;

  AppSettings _settings = AppSettings.initial();

  // ====================================================
  // Getters
  // ====================================================

  bool get isLoading => _isLoading;

  AppSettings get settings => _settings;

  String get language => _settings.language;

  String get themeMode => _settings.themeMode;

  bool get notificationsEnabled => _settings.notificationsEnabled;

  // ====================================================
  // Flutter Theme
  // ====================================================

  ThemeMode get flutterThemeMode {
    switch (_settings.themeMode) {
      case 'light':
        return ThemeMode.light;

      case 'dark':
        return ThemeMode.dark;

      default:
        return ThemeMode.system;
    }
  }

  // ====================================================
  // Flutter Locale
  // ====================================================

  Locale get locale {
    switch (_settings.language) {
      case 'ar':
        return const Locale('ar');

      case 'fr':
        return const Locale('fr');

      default:
        return const Locale('en');
    }
  }

  // ====================================================
  // LOAD SETTINGS
  // ====================================================

  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _settings = await _getSettingsUseCase();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ====================================================
  // CHANGE LANGUAGE
  // ====================================================

  Future<void> changeLanguage(String language) async {
    _settings = _settings.copyWith(language: language);

    await _saveSettingsUseCase(_settings);

    notifyListeners();
  }

  // ====================================================
  // CHANGE THEME
  // ====================================================

  Future<void> changeTheme(String themeMode) async {
    _settings = _settings.copyWith(themeMode: themeMode);

    await _saveSettingsUseCase(_settings);

    notifyListeners();
  }

  // ====================================================
  // CHANGE NOTIFICATIONS
  // ====================================================

  Future<void> changeNotifications(bool enabled) async {
    _settings = _settings.copyWith(notificationsEnabled: enabled);

    await _saveSettingsUseCase(_settings);

    notifyListeners();
  }
}
