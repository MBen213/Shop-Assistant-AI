class SaleItem {
  final String productId;
  final String productName;
  final double price;
  final int quantity;

  const SaleItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  double get subtotal => price * quantity;

  SaleItem copyWith({
    String? productId,
    String? productName,
    double? price,
    int? quantity,
  }) {
    return SaleItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}