import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/famille.dart';
import '../models/menage.dart';
import '../models/personne.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'recensement_database.db'),
      onCreate: (db, version) {
        _createTables(db);
      },
      version: 1,
    );
  }

  static void _createTables(Database db) async {
    await db.execute(
  'CREATE TABLE Menage(menageId INTEGER PRIMARY KEY, nom TEXT, adresse TEXT, quartier TEXT, ville TEXT, nombreFamilles INTEGER)',
);

    await db.execute(
  'CREATE TABLE Famille(familleId INTEGER PRIMARY KEY, nom TEXT, menageId INTEGER, completed INTEGER DEFAULT 0, FOREIGN KEY (menageId) REFERENCES Menage(mengaeId))',
);

    await db.execute(
      'CREATE TABLE Personne(personneId INTEGER PRIMARY KEY, prenom TEXT, nom TEXT, sexe TEXT, dateDeNaissance TEXT, chefFamille INTEGER, lienParente TEXT, familleId INTEGER, FOREIGN KEY (familleId) REFERENCES Famille(familleId))',
    );
  }

   static Future<void> updateMenage(Menage menage) async {
    final db = await database;
    await db.update(
      'Menage',
      menage.toMap(),
      where: 'menageId = ?',
      whereArgs: [menage.menageId],
    );
  }

  static Future<void> updateFamille(Famille famille) async {
    final db = await database;
    await db.update(
      'Famille',
      famille.toMap(),
      where: 'familleId = ?',
      whereArgs: [famille.familleId],
    );
  }

  static Future<void> updatePersonne(Personne personne) async {
    final db = await database;
    await db.update(
      'Personne',
      personne.toMap(),
      where: 'personneId = ?',
      whereArgs: [personne.personneId],
    );
  }

  static Future<List<Map<String, dynamic>>> _queryAllRows(String table) async {
    final Database db = await database;
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getAllMenages() async {
    return _queryAllRows('Menage');
  }
}
