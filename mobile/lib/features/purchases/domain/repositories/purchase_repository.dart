import '../entities/purchase.dart';

abstract class PurchaseRepository {
  Future<List<Purchase>> getPurchases();

  Future<void> addPurchase(
    Purchase purchase,
  );

  Future<void> deletePurchase(
    String id,
  );
}