import 'package:flutter/material.dart';

import '../../data/datasource/purchase_local_datasource.dart';
import '../../data/repositories/purchase_repository_impl.dart';
import '../../domain/entities/purchase.dart';
import '../../domain/usecases/add_purchase_usecase.dart';
import '../../domain/usecases/delete_purchase_usecase.dart';
import '../../domain/usecases/get_purchases_usecase.dart';
import '../../../../core/database/dao/purchases_dao.dart';

class PurchasesProvider extends ChangeNotifier {
  late final GetPurchasesUseCase _getPurchasesUseCase;
  late final AddPurchaseUseCase _addPurchaseUseCase;
  late final DeletePurchaseUseCase _deletePurchaseUseCase;

  PurchasesProvider() {
    final datasource = PurchaseLocalDataSourceImpl(
      PurchasesDao.instance,
    );

    final repository = PurchaseRepositoryImpl(
      datasource,
    );

    _getPurchasesUseCase = GetPurchasesUseCase(
      repository,
    );

    _addPurchaseUseCase = AddPurchaseUseCase(
      repository,
    );

    _deletePurchaseUseCase = DeletePurchaseUseCase(
      repository,
    );

    loadPurchases();
  }

  final List<Purchase> _purchases = [];

  List<Purchase> get purchases => List.unmodifiable(
        _purchases,
      );

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadPurchases() async {
    _isLoading = true;
    notifyListeners();

    _purchases.clear();

    _purchases.addAll(
      await _getPurchasesUseCase(),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPurchase(
    Purchase purchase,
  ) async {
    await _addPurchaseUseCase(
      purchase,
    );

    await loadPurchases();
  }

  Future<void> deletePurchase(
    String id,
  ) async {
    await _deletePurchaseUseCase(
      id,
    );

    await loadPurchases();
  }

  double get totalPurchases {
    return _purchases.fold(
      0,
      (sum, purchase) => sum + purchase.total,
    );
  }

  int get purchasesCount {
    return _purchases.length;
  }
}