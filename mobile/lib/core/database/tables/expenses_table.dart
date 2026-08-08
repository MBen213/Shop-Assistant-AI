class ExpensesTable {
  ExpensesTable._();

  static const String tableName = 'expenses';

  static const String createTable = '''
CREATE TABLE expenses(

  id TEXT PRIMARY KEY,

  title TEXT NOT NULL,

  amount REAL NOT NULL
    CHECK(amount >= 0),

  notes TEXT,

  created_at TEXT NOT NULL

)
''';
}