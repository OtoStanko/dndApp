import 'dart:async';

import 'package:firstapp/db/models/character_model.dart';
import 'package:firstapp/static/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sq;

class Database {
  late Future<sq.Database> _database;

  Database() {
    WidgetsFlutterBinding.ensureInitialized();
    database = _initDB();
    insertCharacter(const Character(
      id: 0,
      name: 'Dary',
      age: 35,
    ));
    insertCharacter(const Character(
      id: 1,
      name: 'Dary',
      age: 35,
    ));
    insertCharacter(const Character(
      id: 2,
      name: 'Dary',
      age: 35,
    ));
  }

  Future<sq.Database> _initDB() async {
    return sq.openDatabase(
      join(await sq.getDatabasesPath(), "$sqliteDBName.db"),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $sqliteCharactersTableName(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<sq.Database> get database async {
    return await _database;
  }

  set database(Future<sq.Database> db) {
    _database = db;
  }

  Future<void> insertCharacter(Character character) async {
    final db = await database;

    await db.insert(
      sqliteCharactersTableName,
      character.toMap(),
      conflictAlgorithm: sq.ConflictAlgorithm.replace,
    );
  }

  Future<List<Character>> characters() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(sqliteCharactersTableName);

    var items = List.generate(maps.length, (i) {
      return Character(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
    return items;
  }

  Future<void> updateCharacter(Character character) async {
    final db = await database;

    await db.update(
      sqliteCharactersTableName,
      character.toMap(),
      where: 'id = ?',
      whereArgs: [character.id],
    );
  }

  Future<void> deleteCharacter(int id) async {
    final db = await database;

    await db.delete(
      sqliteCharactersTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

void main() async {
  // Create a Dog and add it to the dogs table
  var fido = const Character(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  final db = new Database();

  await db.insertCharacter(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await db.characters()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Character(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await db.updateCharacter(fido);

  // Print the updated results.
  print(await db.characters()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await db.deleteCharacter(fido.id);

  // Print the list of dogs (empty).
  print(await db.characters());
}
