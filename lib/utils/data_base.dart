import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class Contact {
  final String name;
  final Map<String, String> numbers;
  final int id;
  bool isfav = false;

  Contact({
    required this.name,
    required this.numbers,
    required this.id,
  });
  Map<String, Object?> toMap() {
    return {'name': name, 'numbers': numbers, 'id': id, 'isfav': isfav};
  }
}

Future<Database> initializeDatabase() async {
  String path = join(await getDatabasesPath(), 'example.db');
  return openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE items (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER)',
      );
    },
  );
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Private constructor
  DatabaseHelper._internal();

  // Factory constructor for singleton
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      numbers TEXT NOT NULL,
      isfav INTEGER NOT NULL
    )
    ''');
  }
}

// Insert
Future<void> insertContact(Contact contact) async {
  final db = await DatabaseHelper().database;

  await db.insert(
    'contacts',
    {
      'name': contact.name,
      'numbers': contact.numbers.toString(),
      'isfav': contact.isfav ? 1 : 0,
      'id': contact.id
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Retreive
Future<List<Contact>> getContacts() async {
  final db = await DatabaseHelper().database;

  final List<Map<String, dynamic>> result = await db.query('contacts');

  return result.map((row) {
    return Contact(
      name: row['name'],
      id: row['id'],
      numbers: Map<String, String>.from(json.decode(row['numbers'])),
    )..isfav = row['isfav'] == 1;
  }).toList();
}

// Update
Future<void> updateContact(Database db, int id, Contact contact) async {
  final contactMap = {
    'name': contact.name,
    'numbers': json.encode(contact.numbers),
    'isfav': contact.isfav ? 1 : 0,
  };
  await db.update(
    'contacts',
    contactMap,
    where: 'id = ?',
    whereArgs: [id],
  );
}

// Delete
Future<void> deleteContact(Database db, int id) async {
  await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
}
