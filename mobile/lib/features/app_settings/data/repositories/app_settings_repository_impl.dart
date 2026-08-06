import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/app_settings_repository.dart';

import '../datasource/app_settings_local_datasource.dart';

class AppSettingsRepositoryImpl
    implements AppSettingsRepository {
  final AppSettingsLocalDataSource
      localDataSource;

  AppSettingsRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<AppSettings> getSettings() async {
    return await localDataSource
        .getSettings();
  }

  @override
  Future<void> saveSettings(
    AppSettings settings,
  ) async {
    await localDataSource
        .saveSettings(settings);
  }
}