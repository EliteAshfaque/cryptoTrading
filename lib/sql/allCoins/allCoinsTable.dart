import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AllCoinsTable {


  Future<void> createAllCoinsTable()async {
    Database database = await openDatabase(join(await getDatabasesPath(), 'AllCoins.db'),
        onCreate: (Database db,int version) async {
          await db.execute(
            "CREATE TABLE AllCoins(symbol TEXT PRIMARY KEY, updatedAt INTEGER, openPrice REAL, closePrice REAL,"
                "askPrice REAL, bidPrice REAL, lowPrice REAL, highPrice REAL,status TEXT,contractAddress TEXT,"
                "network TEXT, canDeposit INTEGER, canWithdrawal INTEGER, imgUrl TEXT,percentageChange TEXT)",
          );
        },version: 1);
  }

}