import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/purchases/data/models/purchase_model.dart';
import '../../features/purchases/domain/entities/purchase_item.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'shop_assistant_ai.db',
    );

    return openDatabase(
      path,
      version: 7,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    // PRODUCTS
    await db.execute('''
CREATE TABLE products(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
barcode TEXT NOT NULL,
purchase_price REAL NOT NULL,
selling_price REAL NOT NULL,
quantity INTEGER NOT NULL
)
''');

    // SALES
    await db.execute('''
CREATE TABLE sales(
id TEXT PRIMARY KEY,
total REAL NOT NULL,
created_at TEXT NOT NULL
)
''');

    // SALE ITEMS
    await db.execute('''
CREATE TABLE sale_items(
id INTEGER PRIMARY KEY AUTOINCREMENT,
sale_id TEXT NOT NULL,
product_id TEXT NOT NULL,
product_name TEXT NOT NULL,
price REAL NOT NULL,
quantity INTEGER NOT NULL,
subtotal REAL NOT NULL
)
''');

    // CUSTOMERS
    await db.execute('''
CREATE TABLE customers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT NOT NULL,
address TEXT,
notes TEXT,
debt REAL NOT NULL DEFAULT 0,
created_at TEXT NOT NULL
)
''');

    // SUPPLIERS
    await db.execute('''
CREATE TABLE suppliers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT NOT NULL,
address TEXT NOT NULL,
email TEXT NOT NULL
)
''');

    // PURCHASES
    await db.execute('''
CREATE TABLE purchases(
id TEXT PRIMARY KEY,
supplierId TEXT NOT NULL,
supplierName TEXT NOT NULL,
date TEXT NOT NULL
)
''');

    // PURCHASE ITEMS
    await db.execute('''
CREATE TABLE purchase_items(
id INTEGER PRIMARY KEY AUTOINCREMENT,
purchaseId TEXT NOT NULL,
productId TEXT NOT NULL,
productName TEXT NOT NULL,
quantity INTEGER NOT NULL,
purchasePrice REAL NOT NULL
)
''');
// USERS
await db.execute('''
CREATE TABLE users(
id TEXT PRIMARY KEY,
username TEXT NOT NULL UNIQUE,
password_hash TEXT NOT NULL,
full_name TEXT NOT NULL,
role TEXT NOT NULL,
is_active INTEGER NOT NULL,
created_at TEXT NOT NULL
)
''');

await db.insert(
  'users',
  {
    'id': 'owner-001',
    'username': 'admin',
    'password_hash': 'admin123',
    'full_name': 'Store Owner',
    'role': 'owner',
    'is_active': 1,
    'created_at': DateTime.now().toIso8601String(),
  },
);
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS sales(
id TEXT PRIMARY KEY,
total REAL NOT NULL,
created_at TEXT NOT NULL
)
''');

      await db.execute('''
CREATE TABLE IF NOT EXISTS sale_items(
id INTEGER PRIMARY KEY AUTOINCREMENT,
sale_id TEXT NOT NULL,
product_id TEXT NOT NULL,
product_name TEXT NOT NULL,
price REAL NOT NULL,
quantity INTEGER NOT NULL,
subtotal REAL NOT NULL
)
''');
    }

    if (oldVersion < 3) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS customers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT NOT NULL,
address TEXT,
notes TEXT,
debt REAL NOT NULL DEFAULT 0,
created_at TEXT NOT NULL
)
''');
    }

    if (oldVersion < 4) {
      try {
        await db.execute(
          'ALTER TABLE customers ADD COLUMN notes TEXT',
        );
      } catch (_) {}

      try {
        await db.execute(
          'ALTER TABLE customers ADD COLUMN debt REAL NOT NULL DEFAULT 0',
        );
      } catch (_) {}
    }

    if (oldVersion < 5) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS suppliers(
id TEXT PRIMARY KEY,
name TEXT NOT NULL,
phone TEXT NOT NULL,
address TEXT NOT NULL,
email TEXT NOT NULL
)
''');
    }

    if (oldVersion < 6) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS purchases(
id TEXT PRIMARY KEY,
supplierId TEXT NOT NULL,
supplierName TEXT NOT NULL,
date TEXT NOT NULL
)
''');

      await db.execute('''
CREATE TABLE IF NOT EXISTS purchase_items(
id INTEGER PRIMARY KEY AUTOINCREMENT,
purchaseId TEXT NOT NULL,
productId TEXT NOT NULL,
productName TEXT NOT NULL,
quantity INTEGER NOT NULL,
purchasePrice REAL NOT NULL
)
''');
    }

    if (oldVersion < 7) {
  await db.execute('''
CREATE TABLE IF NOT EXISTS users(
id TEXT PRIMARY KEY,
username TEXT NOT NULL UNIQUE,
password_hash TEXT NOT NULL,
full_name TEXT NOT NULL,
role TEXT NOT NULL,
is_active INTEGER NOT NULL,
created_at TEXT NOT NULL
)
''');

  final existing = await db.query(
    'users',
    where: 'username = ?',
    whereArgs: ['admin'],
  );

  if (existing.isEmpty) {
    await db.insert(
      'users',
      {
        'id': 'owner-001',
        'username': 'admin',
        'password_hash': 'admin123',
        'full_name': 'Store Owner',
        'role': 'owner',
        'is_active': 1,
        'created_at': DateTime.now().toIso8601String(),
      },
    );
  }
}
  }

  // ===========================
  // PURCHASE METHODS
  // ===========================

  Future<void> insertPurchase(
    PurchaseModel purchase,
  ) async {
    final db = await database;

    await db.insert(
      'purchases',
      purchase.toMap(),
    );

    for (final PurchaseItem item in purchase.items) {
      await db.insert(
        'purchase_items',
        {
          'purchaseId': purchase.id,
          'productId': item.productId,
          'productName': item.productName,
          'quantity': item.quantity,
          'purchasePrice': item.purchasePrice,
        },
      );
    }
  }

  Future<void> deletePurchase(
    String id,
  ) async {
    final db = await database;

    await db.delete(
      'purchase_items',
      where: 'purchaseId = ?',
      whereArgs: [id],
    );

    await db.delete(
      'purchases',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getPurchases() async {
    final db = await database;

    return await db.query(
      'purchases',
      orderBy: 'date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getPurchaseItems(
    String purchaseId,
  ) async {
    final db = await database;

    return await db.query(
      'purchase_items',
      where: 'purchaseId = ?',
      whereArgs: [purchaseId],
    );
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // ===========================
// DASHBOARD STATISTICS
// ===========================

Future<int> getProductsCount() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT COUNT(*) FROM products',
  );

  return Sqflite.firstIntValue(result) ?? 0;
}

Future<int> getCustomersCount() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT COUNT(*) FROM customers',
  );

  return Sqflite.firstIntValue(result) ?? 0;
}

Future<int> getSuppliersCount() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT COUNT(*) FROM suppliers',
  );

  return Sqflite.firstIntValue(result) ?? 0;
}

Future<int> getSalesCount() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT COUNT(*) FROM sales',
  );

  return Sqflite.firstIntValue(result) ?? 0;
}

Future<int> getPurchasesCount() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT COUNT(*) FROM purchases',
  );

  return Sqflite.firstIntValue(result) ?? 0;
}

Future<double> getRevenue() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT SUM(total) FROM sales',
  );

  final value = result.first.values.first;

  if (value == null) {
    return 0;
  }

  return (value as num).toDouble();
}

Future<int> getLowStockProductsCount() async {
  final db = await database;

  final result = await db.rawQuery(
    'SELECT COUNT(*) FROM products WHERE quantity <= 5',
  );

  return Sqflite.firstIntValue(result) ?? 0;
}
// ===========================
// TODAY STATISTICS
// ===========================

Future<int> getTodaySalesCount() async {
  final db = await database;

  final today = DateTime.now().toIso8601String().substring(0, 10);

  final result = await db.rawQuery(
    '''
    SELECT COUNT(*)
    FROM sales
    WHERE substr(created_at,1,10)=?
    ''',
    [today],
  );

  return Sqflite.firstIntValue(result) ?? 0;
}

Future<double> getTodayRevenue() async {
  final db = await database;

  final today = DateTime.now().toIso8601String().substring(0, 10);

  final result = await db.rawQuery(
    '''
   SELECT SUM(total)
   FROM sales
   WHERE substr(created_at,1,10)=?
   ''',
    [today],
  );

  final value = result.first.values.first;

  if (value == null) {
    return 0;
  }

  return (value as num).toDouble();
}

Future<double> getTodayProfit() async {
  
  return 0;
}
}