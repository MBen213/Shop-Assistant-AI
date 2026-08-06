class SalesTable {
  SalesTable._();

  static const String tableName = 'sales';

  static const String createTable = '''
CREATE TABLE sales(

  id TEXT PRIMARY KEY,

  customer_id TEXT,

  total REAL NOT NULL
    CHECK(total >= 0),

  payment_method TEXT NOT NULL,

  created_at TEXT NOT NULL,

  FOREIGN KEY(customer_id)
    REFERENCES customers(id)
    ON DELETE SET NULL
)
''';
}