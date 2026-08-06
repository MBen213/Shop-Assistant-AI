import '../entities/store_settings.dart';
import '../repositories/store_settings_repository.dart';

class GetStoreSettingsUseCase {
  final StoreSettingsRepository repository;

  GetStoreSettingsUseCase(
    this.repository,
  );

  Future<StoreSettings> call() {
    return repository.getSettings();
  }
}