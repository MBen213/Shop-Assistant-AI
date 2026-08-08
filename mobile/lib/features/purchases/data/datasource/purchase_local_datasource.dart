import '../../../../core/database/dao/purchases_dao.dart';

import '../models/purchase_item_model.dart';
import '../models/purchase_model.dart';

abstract class PurchaseLocalDataSource {
  Future<List<PurchaseModel>> getPurchases();

  Future<void> addPurchase(
    PurchaseModel purchase,
  );

  Future<void> deletePurchase(
    String id,
  );
}

class PurchaseLocalDataSourceImpl
    implements PurchaseLocalDataSource {
  final PurchasesDao purchasesDao;

  PurchaseLocalDataSourceImpl(
    this.purchasesDao,
  );

  @override
  Future<void> addPurchase(
    PurchaseModel purchase,
  ) async {
    await purchasesDao.insertPurchase(
      purchase.toMap(),
      purchase.items.map(
        (e) => (e as PurchaseItemModel).toMap(
          purchaseId: purchase.id,
        ),
      )
      .toList(),
    );
  }

  @override
  Future<void> deletePurchase(
    String id,
  ) async {
    await purchasesDao.deletePurchase(id);
  }

  @override
  Future<List<PurchaseModel>> getPurchases() async {
    final purchases =
        await purchasesDao.getPurchases();

    final List<PurchaseModel> result = [];

    for (final purchase in purchases) {
      final items =
          await purchasesDao.getPurchaseItems(
        purchase['id'] as String,
      );

      result.add(
        PurchaseModel.fromMap(
          purchase,
          items
              .map(
                (e) => PurchaseItemModel.fromMap(e),
              )
              .toList(),
        ),
      );
    }

    return result;
  }
}