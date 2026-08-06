import '../entities/app_settings.dart';
import '../repositories/app_settings_repository.dart';

class SaveAppSettingsUseCase {
  final AppSettingsRepository repository;

  SaveAppSettingsUseCase(this.repository);

  Future<void> call(
    AppSettings settings,
  ) async {
    await repository.saveSettings(
      settings,
    );
  }
}