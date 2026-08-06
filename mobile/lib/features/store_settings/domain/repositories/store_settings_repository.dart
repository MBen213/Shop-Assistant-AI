import '../entities/store_settings.dart';

abstract class StoreSettingsRepository {
  Future<StoreSettings> getSettings();

  Future<void> saveSettings(
    StoreSettings settings,
  );
}