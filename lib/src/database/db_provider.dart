import 'dart:io';

import 'package:flutter_sqlite/src/models/anime_response.dart';
import 'package:flutter_sqlite/src/models/customer.dart';
import 'package:flutter_sqlite/src/utils/directory_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider.internal();
  static final DBProvider _instance = new DBProvider.internal();

  factory DBProvider() => _instance;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await setupDB();
    return _database;
  }

  Future<Database> setupDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var newDir = await DirectoryUtil.createFolderInAppDocDir('FLUTTER_IRUFANO');
    print(newDir);
    String path = join(documentsDirectory.path, "LocalDB.db");

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Anime("
        "mal_id INTEGER PRIMARY KEY,"
        "rank INTEGER,"
        "title VARCHAR(191) NOT NULL,"
        "url VARCHAR(191),"
        "image_url VARCHAR(191),"
        "type VARCHAR(191),"
        "episodes INTEGER,"
        "start_date VARCHAR(191),"
        "end_date VARCHAR(191),"
        "members INTEGER,"
        "score INTEGER"
        ")");

    await db.execute("CREATE TABLE Customer("
        "customer_id INTEGER PRIMARY KEY,"
        "name VARCHAR(191) NOT NULL"
        ")");

    await db.execute("CREATE TABLE TransactionOrder("
        "order_id INTEGER PRIMARY KEY,"
        "customer_id INTEGER NOT NULL,"
        "order_date VARCHAR(191),"
        "amount REAL,"
        "FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)"
        ")");
  }

  Future<int> addAnime(Top anime) async {
    var dbClient = await database;
    int result;

    result = await dbClient.insert("Anime", anime.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

  Future<List<Top>> getAllAnimes() async {
    var dbClient = await database;

    var list = await dbClient.query("Anime", orderBy: "rank");
    List<Top> animeList = List<Top>();

    for (var i = 0; i < list.length; i++) {
      animeList.add(Top.fromMap(list[i]));
    }

    return animeList;
  }

  Future<int> addCustomer(Customer customer) async {
    var dbClient = await database;
    int result;

    result = await dbClient.insert("Customer", customer.toMap());

    print('Insert customer local : ' + result.toString());
    return result;
  }

  Future<int> deleteCustomer(int id) async {
    var dbClient = await database;

    int result = await dbClient.delete(
      'Customer',
      where: "customer_id = ?",
      whereArgs: [id],
    );

    print('Delete customer local : ' + result.toString());
    return result;
  }

  Future<int> updateCustomer(Customer customer, int id) async {
    var dbClient = await database;

    int response = await dbClient.update(
      'Customer',
      customer.toMap(),
      where: "customer_id = ?",
      whereArgs: [id],
    );
    return response;
  }

  Future<List<Customer>> getAllCustomer() async {
    var dbClient = await database;

    var list = await dbClient.query("Customer");
    List<Customer> dataList = List<Customer>();

    for (var i = 0; i < list.length; i++) {
      dataList.add(Customer.fromMap(list[i]));
    }

    return dataList;
  }
}
