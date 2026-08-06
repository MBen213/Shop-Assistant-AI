class CustomersTable {
  CustomersTable._();

  static const String tableName = 'customers';

  static const String createTable = '''
CREATE TABLE customers(

  id TEXT PRIMARY KEY,

  name TEXT NOT NULL,

  phone TEXT NOT NULL,

  address TEXT,

  notes TEXT,

  debt REAL NOT NULL DEFAULT 0
    CHECK(debt >= 0),

  created_at TEXT NOT NULL
)
''';
}