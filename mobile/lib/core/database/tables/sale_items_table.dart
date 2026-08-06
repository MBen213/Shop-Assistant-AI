class SaleItemsTable {
  SaleItemsTable._();

  static const String tableName = 'sale_items';

  static const String createTable = '''
CREATE TABLE sale_items(

  id INTEGER PRIMARY KEY AUTOINCREMENT,

  sale_id TEXT NOT NULL,

  product_id TEXT NOT NULL,

  product_name TEXT NOT NULL,

  price REAL NOT NULL
    CHECK(price >= 0),

  quantity INTEGER NOT NULL
    CHECK(quantity > 0),

  subtotal REAL NOT NULL
    CHECK(subtotal >= 0),

  FOREIGN KEY(sale_id)
    REFERENCES sales(id)
    ON DELETE CASCADE,

  FOREIGN KEY(product_id)
    REFERENCES products(id)
    ON DELETE RESTRICT
)
''';
}