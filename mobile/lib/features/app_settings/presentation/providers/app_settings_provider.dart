import 'package:flutter/material.dart';

import '../../data/datasource/app_settings_local_datasource.dart';
import '../../data/repositories/app_settings_repository_impl.dart';

import '../../domain/entities/app_settings.dart';

import '../../domain/usecases/get_app_settings_usecase.dart';
import '../../domain/usecases/save_app_settings_usecase.dart';

class AppSettingsProvider extends ChangeNotifier {
  AppSettingsProvider() {
    _repository = AppSettingsRepositoryImpl(
      AppSettingsLocalDataSource(),
    );

    _getSettingsUseCase =
        GetAppSettingsUseCase(
      _repository,
    );

    _saveSettingsUseCase =
        SaveAppSettingsUseCase(
      _repository,
    );

    loadSettings();
  }

  late final AppSettingsRepositoryImpl
      _repository;

  late final GetAppSettingsUseCase
      _getSettingsUseCase;

  late final SaveAppSettingsUseCase
      _saveSettingsUseCase;

  bool _isLoading = false;

  AppSettings _settings =
      AppSettings.initial();

  bool get isLoading => _isLoading;

  AppSettings get settings => _settings;

  String get language =>
      _settings.language;

  String get themeMode =>
      _settings.themeMode;

  bool get notificationsEnabled =>
      _settings.notificationsEnabled;

  ThemeMode get flutterThemeMode {
    switch (_settings.themeMode) {
      case "light":
        return ThemeMode.light;

      case "dark":
        return ThemeMode.dark;

      default:
        return ThemeMode.system;
    }
  }

  Locale get locale {
    switch (_settings.language) {
      case "ar":
        return const Locale("ar");

      case "fr":
        return const Locale("fr");

      default:
        return const Locale("en");
    }
  }

  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    _settings =
        await _getSettingsUseCase();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeLanguage(
    String language,
  ) async {
    _settings = _settings.copyWith(
      language: language,
    );

    await _saveSettingsUseCase(
      _settings,
    );

    notifyListeners();
  }

  Future<void> changeTheme(
    String themeMode,
  ) async {
    _settings = _settings.copyWith(
      themeMode: themeMode,
    );

    await _saveSettingsUseCase(
      _settings,
    );

    notifyListeners();
  }

  Future<void>
      changeNotifications(
    bool enabled,
  ) async {
    _settings = _settings.copyWith(
      notificationsEnabled: enabled,
    );

    await _saveSettingsUseCase(
      _settings,
    );

    notifyListeners();
  }
}