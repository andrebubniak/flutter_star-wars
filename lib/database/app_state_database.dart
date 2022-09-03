
import 'package:sqflite/sqflite.dart';
import 'package:star_wars/models/app_state.dart';
import 'package:star_wars/models/movie_or_character.dart';

class AppStateDatabase
{
  AppStateDatabase._init();

  static final AppStateDatabase instance = AppStateDatabase._init();

  static Database? _database;

  Future<Database> get database async
  {
    if(_database != null)
    {
      return _database!;
    }

    else
    {
      _database = await _initDatabase("star_wars_database.db");
      return _database!;
    }
  }

  Future<Database> _initDatabase(String dbName) async
  {
    final String dbPath = await getDatabasesPath();
    final completePath = "$dbPath/$dbName";
    return await openDatabase(
      completePath,
      version: 1,
      onCreate: _createDatabase,
      onConfigure: _onConfigure
    );
  }

  Future _createDatabase(Database db, int version) async
  {
    await db.execute(_createAppStateTable);
    await db.execute(_createFavoriteTable);
    await db.execute(_instantiateAppStateTable);
  }


  Future insertFavorite(MovieOrCharacter data) async
  {
    final db = await instance.database;
    db.insert(_favoritesTableName, data.favoriteToMap());
  }

  Future deleteFavorite(MovieOrCharacter favorite) async
  {
    final db = await instance.database;
    db.delete(
      _favoritesTableName,
      where: "name = ? AND type = ?",
      whereArgs: [favorite.name, favorite.dataType.name]
    );
  }

  Future <List<MovieOrCharacter>> getFavorites() async
  {
    final db = await instance.database;
    List<Map> maps = await db.query(_favoritesTableName);

    List<MovieOrCharacter> list = List.empty(growable: true);
    for (var element in maps)
    {
      list.add(MovieOrCharacter.favoriteFromMap(element));
    }
    return list;
  }


  Future updateAvatar(String avatar) async
  {
    final db = await instance.database;
    await db.rawUpdate('''UPDATE $_appStateTableName SET avatar = '$avatar' WHERE id = 1''');
  }

  Future<String> getAvatar() async
  {
    final db = await instance.database;
    final maps =  await db.query(_appStateTableName);
    return AppState.fromMap(maps.first).avatar;
  }

  Future _onConfigure(Database db) async 
  {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  Future close() async
  {
    final db = await instance.database;
    db.close();
  }

}



//db queries

//types of data
const String _idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
const String _textType = "TEXT NOT NULL";
const String _integerType = "INTEGER NOT NULL";

//tables names
const String _appStateTableName = "app_state";
const String _favoritesTableName = "favorite";

const String _createAppStateTable = 
'''
CREATE TABLE $_appStateTableName
(
  id $_idType,
  avatar $_textType
);
''';

const String _createFavoriteTable = 
'''
CREATE TABLE $_favoritesTableName
(
  name $_textType,
  type $_textType,
  appState_id $_integerType,
  FOREIGN KEY (appState_id) REFERENCES $_appStateTableName (id) ON DELETE NO ACTION ON UPDATE NO ACTION
  PRIMARY KEY (name, type)
)
''';

const String _instantiateAppStateTable = '''INSERT INTO $_appStateTableName VALUES(1, "{}");''';