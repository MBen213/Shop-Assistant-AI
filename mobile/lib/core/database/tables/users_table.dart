class UsersTable {
  UsersTable._();

  static const String tableName = 'users';

  static const String createTable = '''
CREATE TABLE users(

  id TEXT PRIMARY KEY,

  full_name TEXT NOT NULL,

  username TEXT NOT NULL UNIQUE,

  password TEXT NOT NULL,

  role TEXT NOT NULL,

  is_active INTEGER NOT NULL DEFAULT 1,

  created_at TEXT NOT NULL

)
''';
}