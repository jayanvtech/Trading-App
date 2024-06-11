import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../GetApiService/apiservices.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('trading12.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("Opening database at $path");
    return await openDatabase(path,
        version: 4, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future<void> _createDB(Database db, int version) async {
    try {
      print("Creating tables...");
      await db.execute('''
      CREATE TABLE IF NOT EXISTS watchlists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
      print("watchlists table created.");
      await db.execute('''
      CREATE TABLE IF NOT EXISTS watchlist_instruments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        watchlist_id INTEGER,
        exchange_instrument_id TEXT NOT NULL,
        display_name TEXT NOT NULL,
        Series TEXT NOT NULL,
        exchangeSegment TEXT,
        orderIndex INTEGER,
        close TEXT,
   
        FOREIGN KEY (watchlist_id) REFERENCES watchlists (id) ON DELETE CASCADE
      )
    ''');
      print("watchlist_instruments table created.");
    } catch (e) {
      print("Error creating tables: $e");
    }
  }

  Future<DateTime?> getLatestWatchlistUpdateTimestamp(int watchlistId) async {
    final db = await database;
    final result = await db.query(
      'watchlist_instruments',
      columns: ['MAX(last_modified)'],
      where: 'watchlist_id = ?',
      whereArgs: [watchlistId],
    );
    if (result.isNotEmpty && result.first['MAX(last_modified)'] != null) {
      return DateTime.parse(result.first['MAX(last_modified)'].toString());
    }
    return null;
  }
 Future<int> deleteInstrumentByExchangeInstrumentId(int watchlistId, String exchangeInstrumentId) async {
    final db = await instance.database;
    return await db.delete(
      'watchlist_instruments',
      where: 'watchlist_id = ? AND exchange_instrument_id = ?',
      whereArgs: [watchlistId, exchangeInstrumentId],
    );
  }
  Future<int> addWatchlist(String name) async {
    final db = await instance.database;
    // Check if there are already 10 watchlists
    List<Map> existing = await db.query('watchlists');
    if (existing.length >= 10) {
      throw Exception('Maximum of 10 watchlists reached.');
    }
    return await db.insert(
      'watchlists',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addInstrumentToWatchlist(
      int watchlistId,
      String exchangeInstrumentId,
      String displayName,
      String Series,
      String exchangeSegment,
      int orderIndex,
      String close) async {
    final db = await instance.database;
    final json = {
      'watchlist_id': watchlistId,
      'exchange_instrument_id': exchangeInstrumentId,
      'display_name': displayName,
      'Series': Series,
      'exchangeSegment': exchangeSegment,
      'orderIndex': orderIndex,
      'close': close,
    };
    return await db.insert(
      'watchlist_instruments',
      json,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchWatchlists() async {
    final db = await instance.database;
    return await db.query('watchlists');
  }

  Future<List<Map<String, dynamic>>> fetchInstrumentsByWatchlist(
      int watchlistId) async {
    final db = await instance.database;
    return await db.query(
      'watchlist_instruments',
      where: 'watchlist_id = ?',
      whereArgs: [watchlistId],
      orderBy: 'orderIndex ASC',
    );
  }

  Future<void> updateOrderIndex(int id, int newIndex) async {
    final db = await database;
    await db.update(
      'watchlist_instruments',
      {'orderIndex': newIndex},
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Order index updated for id $id to $newIndex");
  }

  Future<void> updateAllCloseValues() async {
    final db = await database;
    final instruments = await db.query('watchlist_instruments');

    for (var instrument in instruments) {
      try {
        String closeValue = await ApiService().GetBhavCopy(
          instrument['exchange_instrument_id'] as String,
          instrument['exchangeSegment'] as String,
        );
        await db.update('watchlist_instruments', {'close': closeValue},
            where: 'id = ?', whereArgs: [instrument['id']]);
      } catch (e) {
        print(
            'Error updating close value for instrument ID ${instrument['id']}: $e');
      }
    }
  }

  Future<void> updateOrderIndexForWatchlist(
      int watchlistId, List<int> newOrder) async {
    final db = await database;
    List<Map<String, dynamic>> instruments =
        await fetchInstrumentsByWatchlist(watchlistId);
    for (int i = 0; i < instruments.length; i++) {
      await updateOrderIndex(instruments[i]['id'], newOrder[i]);
    }
  }

  Future<int> deleteInstrumentFromWatchlist(int id) async {
    final db = await instance.database;
    return await db
        .delete('watchlist_instruments', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteWatchlist(int id) async {
    final db = await instance.database;
    await db.delete('watchlist_instruments',
        where: 'watchlist_id = ?', whereArgs: [id]);
    return await db.delete('watchlists', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      if (oldVersion < 6) {
        // Assume this change is in version 2
        await db.execute('''
          CREATE TABLE watchlist_instruments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            watchlist_id INTEGER,
            exchange_instrument_id INTEGER,
            display_name TEXT,
            Series TEXT,
            exchangeSegment INTEGER,
            orderIndex INTEGER,
            close TEXT,
      
            FOREIGN KEY(watchlist_id) REFERENCES watchlists(id),
          )
        ''');
      }
    } catch (e) {
      print("Error upgrading database: $e");
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
