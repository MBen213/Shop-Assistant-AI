class ProductsTable {
  ProductsTable._();

  static const String tableName = 'products';

  static const String createTable = '''
CREATE TABLE products(
  id TEXT PRIMARY KEY,

  name TEXT NOT NULL,

  barcode TEXT NOT NULL UNIQUE,

  purchase_price REAL NOT NULL
    CHECK(purchase_price >= 0),

  selling_price REAL NOT NULL
    CHECK(selling_price >= 0),

  quantity INTEGER NOT NULL DEFAULT 0
    CHECK(quantity >= 0)
)
''';
}