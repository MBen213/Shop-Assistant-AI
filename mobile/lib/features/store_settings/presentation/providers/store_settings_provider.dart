import 'package:flutter/material.dart';

import '../../data/datasource/store_settings_local_datasource.dart';
import '../../data/repositories/store_settings_repository_impl.dart';

import '../../domain/entities/store_settings.dart';
import '../../domain/usecases/get_store_settings_usecase.dart';
import '../../domain/usecases/save_store_settings_usecase.dart';

class StoreSettingsProvider extends ChangeNotifier {
  StoreSettingsProvider() {
    _repository = StoreSettingsRepositoryImpl(
      StoreSettingsLocalDataSource(),
    );

    _getSettingsUseCase = GetStoreSettingsUseCase(
      _repository,
    );

    _saveSettingsUseCase = SaveStoreSettingsUseCase(
      _repository,
    );

    loadSettings();
  }

  late final StoreSettingsRepositoryImpl _repository;

  late final GetStoreSettingsUseCase
      _getSettingsUseCase;

  late final SaveStoreSettingsUseCase
      _saveSettingsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  StoreSettings _settings =
      StoreSettings.empty();

  StoreSettings get settings => _settings;

  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    _settings = await _getSettingsUseCase();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveSettings(
    StoreSettings settings,
  ) async {
    _isLoading = true;
    notifyListeners();

    await _saveSettingsUseCase(settings);

    _settings = settings;

    _isLoading = false;
    notifyListeners();
  }

  void updateStoreName(String value) {
    _settings = _settings.copyWith(
      storeName: value,
    );
    notifyListeners();
  }

  void updateAddress(String value) {
    _settings = _settings.copyWith(
      address: value,
    );
    notifyListeners();
  }

  void updatePhone(String value) {
    _settings = _settings.copyWith(
      phone: value,
    );
    notifyListeners();
  }

  void updateEmail(String value) {
    _settings = _settings.copyWith(
      email: value,
    );
    notifyListeners();
  }

  void updateCurrency(String value) {
    _settings = _settings.copyWith(
      currency: value,
    );
    notifyListeners();
  }

  void updateTax(double value) {
    _settings = _settings.copyWith(
      taxPercentage: value,
    );
    notifyListeners();
  }

  void updateFooter(String value) {
    _settings = _settings.copyWith(
      receiptFooter: value,
    );
    notifyListeners();
  }

  void updateLogo(String? path) {
    _settings = _settings.copyWith(
      logoPath: path,
    );
    notifyListeners();
  }
}