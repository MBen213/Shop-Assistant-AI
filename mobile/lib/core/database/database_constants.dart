class DatabaseConstants {
  DatabaseConstants._();

  // ====================================================
  // Database
  // ====================================================

  static const String databaseName =
      'shop_assistant_ai.db';

  static const int databaseVersion = 9;

  // ====================================================
  // Stock Movement Types
  // ====================================================

  static const String stockMovementInitial =
      'initial';

  static const String stockMovementPurchase =
      'purchase';

  static const String stockMovementSale =
      'sale';

  static const String stockMovementAdjustment =
      'adjustment';

  static const String stockMovementReturn =
      'return';
}