class PurchaseItemsTable {
  PurchaseItemsTable._();

  static const String tableName = 'purchase_items';

  static const String createTable = '''
CREATE TABLE purchase_items(

  id INTEGER PRIMARY KEY AUTOINCREMENT,

  purchase_id TEXT NOT NULL,

  product_id TEXT NOT NULL,

  product_name TEXT NOT NULL,

  quantity INTEGER NOT NULL
    CHECK(quantity > 0),

  purchase_price REAL NOT NULL
    CHECK(purchase_price >= 0),

  FOREIGN KEY(purchase_id)
    REFERENCES purchases(id)
    ON DELETE CASCADE,

  FOREIGN KEY(product_id)
    REFERENCES products(id)
    ON DELETE RESTRICT
)
''';
}