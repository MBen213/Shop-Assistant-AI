import '../../../../core/database/dao/sales_dao.dart';

import '../models/sale_item_model.dart';
import '../models/sale_model.dart';

class SaleLocalDataSource {
  final SalesDao _dao = SalesDao.instance;

  // ==========================
  // GET SALES
  // ==========================

  Future<List<SaleModel>> getSales() async {
    final salesResult = await _dao.getSales();

    List<SaleModel> sales = [];

    for (final saleMap in salesResult) {
      final itemsResult = await _dao.getItems(
        saleMap['id'] as String,
      );

      final items = itemsResult
          .map(
            (e) => SaleItemModel.fromMap(e),
          )
          .toList();

      sales.add(
        SaleModel.fromMap(
          saleMap,
          items,
        ),
      );
    }

    return sales;
  }

  // ==========================
  // COMPLETE SALE
  // ==========================

  Future<void> completeSale(
    SaleModel sale,
  ) async {
    await _dao.insertSale(
      sale.toMap(),
      sale.items.map((item) {
        final saleItem =
            SaleItemModel.fromEntity(item);

        return {
          ...saleItem.toMap(),
          'sale_id': sale.id,
          'subtotal': saleItem.subtotal,
        };
      }).toList(),
    );
  }

  // ==========================
  // DELETE SALE
  // ==========================

  Future<void> deleteSale(
    String id,
  ) async {
    await _dao.deleteSale(id);
  }
}