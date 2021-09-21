import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:restorant_app/Database/User.dart';

class DatabaseHelper {
  DatabaseHelper();
  final String tableUser = "User";
  final String columnName = "Fullname";
  final String columnEmail = "Email";
  final String columnPassword = "password";
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _db;
  Future<Database> get db async => _db ??= await initDb();

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "Test.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print('Db location : $path');
    return ourDb;
  }
  /*
    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load("assets/example.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    var db = await openDatabase(path,
        version: 1, readOnly: true, onCreate: _onCreate);
    return db;

   Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    print(path);
    await deleteDatabase(path);
    print(path);
    ByteData data = await rootBundle.load("assets/example.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);*/

  void _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE User(Fullname TEXT, Email TEXT, password TEXT)");
    print("Table is created");
  }

  //insertion
  Future<int> saveUser(user) async {
    var dbClient = await db;
    print(user.FullName);
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    return res;
  }

  //deletion
  Future<int> deleteUser(user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  //Selection
  Future<int?> selectUser(user) async {
    print("Select User");
    print(user.Email);
    print(user.Password);
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnEmail, columnPassword],
        where: "$columnEmail = ? and $columnPassword = ?",
        whereArgs: [user.Email, user.Password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return user;
    } else {
      print('User does not exist !!!');
      return null;
    }
  }

  //Logging_in
  Future<User?> getLogin(user) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnEmail, columnPassword],
        where: "$columnEmail = ? and $columnPassword = ?",
        whereArgs: [user.Email, user.Password]);
    print(maps);
    if (maps.length > 0) {
      print("working");
      return user;
    }
    return null;
  }
}
