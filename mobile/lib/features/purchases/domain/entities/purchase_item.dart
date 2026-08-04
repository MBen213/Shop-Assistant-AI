class PurchaseItem {
  final String productId;
  final String productName;
  final int quantity;
  final double purchasePrice;

  const PurchaseItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.purchasePrice,
  });

  double get total => quantity * purchasePrice;

  PurchaseItem copyWith({
    String? productId,
    String? productName,
    int? quantity,
    double? purchasePrice,
  }) {
    return PurchaseItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
    );
  }
}