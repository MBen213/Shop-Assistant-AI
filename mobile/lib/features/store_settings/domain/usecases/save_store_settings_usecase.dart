import '../entities/store_settings.dart';
import '../repositories/store_settings_repository.dart';

class SaveStoreSettingsUseCase {
  final StoreSettingsRepository repository;

  SaveStoreSettingsUseCase(
    this.repository,
  );

  Future<void> call(
    StoreSettings settings,
  ) {
    return repository.saveSettings(settings);
  }
}