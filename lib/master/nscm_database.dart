import 'package:sqflite/sqflite.dart';
import 'package:tradingapp/master/nscm.dart';

class NscmDatabase {
  static final String _dbName = 'nifty_data1.db';
  static final int _dbVersion = 1;
  static final String _tableNiftyData = 'nifty_data';
  static final String colExchange = 'Exchange';
  static final String colSegment = 'Segment';
  static final String colToken = 'Token';
  static final String colSymbol = 'symbol';
  static final String colStockName = 'Stock_name';
  static final String colInstrumentType = 'instrument_type';
  static final String colExp = 'exp';
  static final String colLotSize = 'lot_size';
  static final String colMultiplier = 'Multiplier';
  static final String colFreezeQty = 'FreezeQty';
  static final String colPriceBandHigh = 'PriceBand_High';
  static final String colPriceBandLow = 'PriceBand_Low';
  static final String colFutureToken = 'futureToken';
  static final String colClose = 'close';

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      '$dbPath/$_dbName',
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableNiftyData (
            $colExchange TEXT NOT NULL,
            $colSegment TEXT NOT NULL,
            $colToken INTEGER PRIMARY KEY,
            $colSymbol TEXT NOT NULL,
            $colStockName TEXT NOT NULL,
            $colInstrumentType TEXT NOT NULL,
            $colExp TEXT NOT NULL,
          
            $colLotSize INTEGER NOT NULL,
          
            $colMultiplier REAL NOT NULL,
            $colFreezeQty REAL NOT NULL,
            $colPriceBandHigh REAL NOT NULL,
            $colPriceBandLow REAL NOT NULL,
            $colFutureToken INTEGER NOT NULL,
            $colClose REAL NOT NULL
          )
        ''');
      },
      version: _dbVersion,
    );
  }

  Future<void> insertNscmData(List<NscmData> data) async {
  final db = await database;

  Batch batch = db.batch();

  for (var item in data) {
    batch.insert(
      'nifty_data',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // replace the existing row if the Token is the same
    );
  }

  await batch.commit(noResult: true);
}

  Future<List<NscmData>> getNscmData() async {
    final db = await database;
    final maps = await db.query(_tableNiftyData);
    return maps.isNotEmpty
        ? maps.map((item) => NscmData.fromJson(item)).toList()
        : [];
  }

  Future<String> getCloseValue(token) async {
    final db = await database;
    final maps = await db.query(
      _tableNiftyData,
      columns: ['close'],
      where: 'Token = ?',
      whereArgs: [token],
    );

    if (maps.isNotEmpty) {
      final close = maps[0]['close'].toString();
      print('Close value: $close');
      print(close.toString());
      return close.toString();
    }
    return '0';
  }

  Future<void> updateNscmData(List<NscmData> data) async {
    final db = await database;
    final batch = db.batch();

    for (var item in data) {
      batch.update(_tableNiftyData, item.toJson(),
          where: '$colToken = ?', whereArgs: [item.token]);
    }

    await batch.commit();
  }
}
