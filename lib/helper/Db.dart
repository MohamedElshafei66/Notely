import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Db{
  static Database? _database;
  Future<Database?> get db async{
    if(_database == null){
      _database = await initial();
      return _database;
    }
    else{
      return _database;
    }
  }
  initial()async{
    String databasePath = await getDatabasesPath();
    String databaseName = join(databasePath,'Mine');
    Database database = await openDatabase(databaseName ,onCreate:onCreate, version:1);
    return database;
  }
  deleteData()async{
    String databasePath = await getDatabasesPath();
    String databaseName = join(databasePath,'Mine');
  await  deleteDatabase(databaseName);
  }
  onCreate(Database db , int version)async{
    await db.execute('''
    CREATE TABLE "folders"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "folder" TEXT NOT NULL,
    "userId" TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE "notes"(
    "idNote" INTEGER PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "folderId" INTEGER,
     FOREIGN KEY(folderId) REFERENCES folders(id) ON DELETE CASCADE
    )
    ''');
    print ("onCreate.....");
  }
  read(String sql)async{
    Database? database = await db;
    List<Map> response = await database!.rawQuery(sql);
    return response;
  }
  add(String sql)async{
    Database? database = await db;
    int response = await database!.rawInsert(sql);
    return response;
  }
  edit(String sql)async{
    Database? database = await db;
    int response = await database!.rawUpdate(sql);
    return response;
  }
  delete(String sql)async{
    Database? database = await db;
    int response = await database!.rawDelete(sql);
    return response;
  }
}