import 'sale_item_model.dart';

class CreateSaleRequest {
  final String saleId;

  final List<SaleItemModel> items;

  final DateTime createdAt;

  const CreateSaleRequest({
    required this.saleId,
    required this.items,
    required this.createdAt,
  });

  /// إجمالي الفاتورة
  double get total {
    return items.fold(
      0,
      (sum, item) => sum + item.subtotal,
    );
  }

  /// عدد المنتجات داخل الفاتورة
  int get totalItems {
    return items.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;
}