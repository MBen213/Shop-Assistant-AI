class Product {
  final String id;
  final String name;
  final String barcode;
  final double purchasePrice;
  final double sellingPrice;
  final int quantity;

  const Product({
    required this.id,
    required this.name,
    required this.barcode,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.quantity,
  });

  double get profit => sellingPrice - purchasePrice;

  Product copyWith({
    String? id,
    String? name,
    String? barcode,
    double? purchasePrice,
    double? sellingPrice,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}