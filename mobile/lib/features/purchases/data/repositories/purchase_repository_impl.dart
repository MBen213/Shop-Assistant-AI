import '../../domain/entities/purchase.dart';
import '../../domain/repositories/purchase_repository.dart';
import '../datasource/purchase_local_datasource.dart';
import '../models/purchase_model.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseLocalDataSource datasource;

  PurchaseRepositoryImpl(this.datasource);

  @override
  Future<void> addPurchase(
    Purchase purchase,
  ) {
    return datasource.addPurchase(
      purchase as PurchaseModel,
    );
  }

  @override
  Future<void> deletePurchase(
    String id,
  ) {
    return datasource.deletePurchase(id);
  }

  @override
  Future<List<Purchase>> getPurchases() {
    return datasource.getPurchases();
  }
}