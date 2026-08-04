import '../../../../core/database/database_helper.dart';
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
  final DatabaseHelper databaseHelper;

  PurchaseLocalDataSourceImpl(
    this.databaseHelper,
  );

  @override
  Future<void> addPurchase(
    PurchaseModel purchase,
  ) async {
    await databaseHelper.insertPurchase(
      purchase,
    );
  }

  @override
  Future<void> deletePurchase(
    String id,
  ) async {
    await databaseHelper.deletePurchase(
      id,
    );
  }

  @override
  Future<List<PurchaseModel>> getPurchases() async {
    final purchases =
        await databaseHelper.getPurchases();

    final List<PurchaseModel> result = [];

    for (final purchase in purchases) {
      final items =
          await databaseHelper.getPurchaseItems(
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