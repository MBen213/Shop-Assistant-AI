class PurchasesTable {
  PurchasesTable._();

  static const String tableName = 'purchases';

  static const String createTable = '''
CREATE TABLE purchases(

  id TEXT PRIMARY KEY,

  supplier_id TEXT NOT NULL,

  total REAL NOT NULL
    CHECK(total >= 0),

  created_at TEXT NOT NULL,

  FOREIGN KEY(supplier_id)
    REFERENCES suppliers(id)
    ON DELETE RESTRICT
)
''';
}