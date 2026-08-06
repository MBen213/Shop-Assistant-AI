import '../../domain/entities/store_settings.dart';
import '../../domain/repositories/store_settings_repository.dart';

import '../datasource/store_settings_local_datasource.dart';

class StoreSettingsRepositoryImpl
    implements StoreSettingsRepository {
  final StoreSettingsLocalDataSource
      localDataSource;

  StoreSettingsRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<StoreSettings> getSettings() {
    return localDataSource.getSettings();
  }

  @override
  Future<void> saveSettings(
    StoreSettings settings,
  ) {
    return localDataSource.saveSettings(
      settings,
    );
  }
}