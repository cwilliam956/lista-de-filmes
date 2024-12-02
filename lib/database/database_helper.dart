import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'movie_list.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT, release_date TEXT, overview TEXT, poster_path TEXT)',
          );
        },
      );
    } catch (e) {
      throw Exception('Erro ao iniciar banco de dados: $e');
    }
  }

  Future<void> addMovie(Map<String, dynamic> movie) async {
    try {
      final db = await database;
      await db.insert(
        'movies',
        movie,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Erro ao adicionar filme: $e');
    }
  }

  Future<void> removeMovie(int id) async {
    try {
      final db = await database;
      await db.delete(
        'movies',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Erro ao remover filme: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMovies() async {
    try {
      final db = await database;
      return await db.query('movies');
    } catch (e) {
      throw Exception('Erro ao recuperar filmes: $e');
    }
  }
}
