import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await intialDb();
    }
    return _db!;
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'hasan.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 5, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE "notes"(
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "note" TEXT NOT NULL
   )
''');

    print('data base created====================');
  }

  _onUpgrade(Database db, int oldVersion, int newVerion) async {
    print('onUpgrade====================');
    await db.execute("ALTER TABLE notes ADD COLUMN title TEXT");
  }

//SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb.rawQuery(sql);
    return response;
  }

//INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb.rawInsert(sql);
    return response;
  }

//UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb.rawUpdate(sql);
    return response;
  }

//DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb.rawDelete(sql);
    return response;
  }
}
