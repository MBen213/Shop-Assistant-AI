class SuppliersTable {
  SuppliersTable._();

  static const String tableName = 'suppliers';

  static const String createTable = '''
CREATE TABLE suppliers(

  id TEXT PRIMARY KEY,

  name TEXT NOT NULL,

  phone TEXT NOT NULL,

  address TEXT,

  email TEXT,

  created_at TEXT NOT NULL
)
''';
}