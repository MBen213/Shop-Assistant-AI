class StockMovementsTable {
  StockMovementsTable._();

  static const String tableName = 'stock_movements';

  static const String createTable = '''
CREATE TABLE stock_movements(
  id TEXT PRIMARY KEY,

  product_id TEXT NOT NULL,

  type TEXT NOT NULL,

  quantity REAL NOT NULL
    CHECK(quantity != 0),

  reference_id TEXT,

  notes TEXT,

  created_at TEXT NOT NULL,

  FOREIGN KEY(product_id)
    REFERENCES products(id)
    ON DELETE CASCADE
)
''';
}