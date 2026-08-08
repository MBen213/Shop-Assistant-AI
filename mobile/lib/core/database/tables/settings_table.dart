class SettingsTable {
  SettingsTable._();

  static const String tableName = 'settings';

  static const String createTable = '''
CREATE TABLE settings(

  id INTEGER PRIMARY KEY CHECK(id = 1),

  shop_name TEXT,

  shop_phone TEXT,

  shop_address TEXT,

  currency TEXT NOT NULL DEFAULT 'DZD',

  dark_mode INTEGER NOT NULL DEFAULT 0

)
''';
}