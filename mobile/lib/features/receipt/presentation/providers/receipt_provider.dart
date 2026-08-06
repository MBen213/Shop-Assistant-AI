import 'package:flutter/material.dart';

import '../../data/datasource/receipt_local_datasource.dart';
import '../../data/repositories/receipt_repository_impl.dart';

import '../../domain/entities/receipt.dart';
import '../../domain/usecases/get_receipt_usecase.dart';

class ReceiptProvider extends ChangeNotifier {
  ReceiptProvider() {
    _repository = ReceiptRepositoryImpl(
      ReceiptLocalDataSource(),
    );

    _getReceiptUseCase = GetReceiptUseCase(
      _repository,
    );
  }

  late final ReceiptRepositoryImpl _repository;

  late final GetReceiptUseCase _getReceiptUseCase;

  Receipt? _receipt;

  Receipt? get receipt => _receipt;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  Future<void> loadReceipt(
    String saleId,
  ) async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _receipt = await _getReceiptUseCase(
        saleId,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void clearReceipt() {
    _receipt = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}