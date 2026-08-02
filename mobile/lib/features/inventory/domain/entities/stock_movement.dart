class StockMovement {
  final String id;
  final String productId;
  final String productName;
  final int quantityAdded;
  final DateTime createdAt;

  const StockMovement({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantityAdded,
    required this.createdAt,
  });

  StockMovement copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantityAdded,
    DateTime? createdAt,
  }) {
    return StockMovement(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantityAdded: quantityAdded ?? this.quantityAdded,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}