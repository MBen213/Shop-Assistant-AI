class ReceiptItem {
  final String productId;
  final String productName;
  final double price;
  final int quantity;

  const ReceiptItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  double get subtotal => price * quantity;

  ReceiptItem copyWith({
    String? productId,
    String? productName,
    double? price,
    int? quantity,
  }) {
    return ReceiptItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ReceiptItem.fromMap(Map<String, dynamic> map) {
    return ReceiptItem(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'ReceiptItem(productName: $productName, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReceiptItem &&
            runtimeType == other.runtimeType &&
            productId == other.productId &&
            productName == other.productName &&
            price == other.price &&
            quantity == other.quantity;
  }

  @override
  int get hashCode => Object.hash(
        productId,
        productName,
        price,
        quantity,
      );
}