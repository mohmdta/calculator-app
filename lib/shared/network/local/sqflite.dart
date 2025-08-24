import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
class SqfliteHelper {

  static Database? _db;
  Future<Database?>? get db async{
     if(_db == null){
       _db = await initalDb();
       return _db;
     }else{
      return _db;
     }
  }
  initalDb()async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "myapp.db");
    Database mydb = await openDatabase(path, onCreate: onCreate, onUpgrade: onUpgrade, version: 1);
    return mydb;
  }
  onUpgrade(Database? db, int oldversion, int newversion){}

  onCreate(Database db , int version)async{
    await db.execute('''
     CREATE TABLE "calculator_history" (
       "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       "Date" TEXT NOT NULL,
       "Equation" TEXT NOT NULL,
       "Result" TEXT NOT NULL
     )
    ''');
    print("onCraete =============================================");
  }
  readData(String sql)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
  insert(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  delete(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}