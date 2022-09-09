import "character.dart";

import 'dart:async';

// import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CharactersDatabase{

  late Future<Database> database;
  

  void openDBFunction() async {
// open the database
    database = await openDatabase(join(await getDatabasesPath(), 'characters_database.db'), 
      version: 1,
      onCreate: (Database db, int version) async {
      // When creating the db, create the table
        await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, charName TEXT, charClass INTEGER, charLvl INTEGER)');
      }
    ) as Future<Database>;
}

  // ignore: non_constant_identifier_names
  CharactersDatabase() {
    openDBFunction();
    
    var skreee = const Character(
      id: 0,
      charName: 'skreee',
      charClass: 0,
      charLvl: 9,
    );
    insertCharacter(skreee);
  }


  Future<void> insertCharacter(Character character) async {
    final db = await database;

    await db.insert(
      'characters',
      character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Character>> getCharacters() async {
    // Get a reference to the database.
    final db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('characters');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Character(
        id: maps[i]['id'],
        charName: maps[i]['name'],
        charClass: maps[i]['class'],
        charLvl: maps[i]['lvl'],
      );
    });
  }
  
}