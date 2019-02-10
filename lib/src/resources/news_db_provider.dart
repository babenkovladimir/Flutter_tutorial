import 'dart:io';

import 'package:flutter_app/src/models/item_model.dart';
import 'package:flutter_app/src/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/*
* Для инициализации данного класса необходим асинхронный код. Нельзя создать конструктор с асинхронным кодом.
* Потому делаем свою функцию init();
* */
class NewsDbProvider implements Source, Cache {
  // Variables

  Database db;

  //Constructort
  NewsDbProvider() {
    init();
  }

  // Todo store and fetch top ids
  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items1.db'); // join оператор объединения, а не асинхронщина

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          );
        ''');
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final Future<List<Map<String, dynamic>>> mapsFuture = db.query(
      "Items",
      columns: null, // если указать конкретный колумн, его и получим. Если указать null, получив все асоциирующие колонки!
      where: "id = ?",
      whereArgs: [id],
    );

    final maps = await mapsFuture;

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item) async {
    return db.insert("Items", item.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();
