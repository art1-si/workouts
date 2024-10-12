import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:workouts/data/clients/sql_client/sql_script_loader.dart';

class SqlDatabaseClient {
  const SqlDatabaseClient._internal({
    required this.database,
  });

  static SqlDatabaseClient? _instance;

  /// Gets an instance of the [SqlDatabaseClient].
  ///
  /// If an instance already exists, it will be returned.
  /// Otherwise, a new instance will be created and returned.
  ///
  /// The [databaseVersion] parameter is used to specify the version of the database.
  /// If the database already exists, but the version is different, the `onUpgrade` callback will be called.
  /// If the database does not exist, the `onCreate` callback will be called.
  static Future<SqlDatabaseClient> getInstance({int databaseVersion = 1}) async {
    if (_instance != null) {
      return _instance!;
    }
    final path = join(await sqflite.getDatabasesPath(), _databaseName);
    final database =
        await sqflite.openDatabase(path, version: databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _instance = SqlDatabaseClient._internal(database: database);
    return _instance!;
  }

  /// The underlying sqflite database.
  /// This should be used to interact with the database.
  final sqflite.Database database;

  /// Name of the database file.
  static const _databaseName = 'workouts.db';

  /// Callback for creating the database.
  ///
  /// This callback is called when the database is created.
  static FutureOr<void> _onCreate(sqflite.Database db, int version) async {
    final createScript = SqlScriptLoader.load('create.sql');
    if (createScript.isEmpty) {
      throw Exception('Failed to load create script');
    }
    return db.execute(createScript);
  }

  /// Callback for upgrading the database.
  static FutureOr<void> _onUpgrade(sqflite.Database db, int oldVersion, int newVersion) {
    throw UnimplementedError('Upgrade of the database is not implemented');
  }

  /// Executes a SQL query on the database.
  /// The [parser] function is used to parse the results of the query.
  /// The [whereClause] and [whereArgs] parameters are used to filter the results.
  /// Returns a list of parsed results.
  /// If no results are found, an empty list is returned.
  Future<List<T>> query<T>({
    required String table,
    required T Function(Map<String, dynamic>) parser,
    String? whereClause,
    List<Object?>? whereArgs,
  }) async {
    final result = await database.query(table, where: whereClause, whereArgs: whereArgs);
    return result.map((e) => parser(e)).toList();
  }

  /// Executes a SQL query on the database.
  /// The [parser] function is used to parse the results of the query.
  /// The [whereClause] and [whereArgs] parameters are used to filter the results.
  /// Returns a single parsed result.
  /// If no results are found, null is returned.
  Future<T?> querySingle<T>({
    required String table,
    required T Function(Map<String, dynamic>) parser,
    String? whereClause,
    List<Object?>? whereArgs,
  }) async {
    final result = await database.query(table, where: whereClause, whereArgs: whereArgs);
    if (result.isEmpty) {
      return null;
    }
    return parser(result.first);
  }

  /// Inserts a new row into the database.
  /// The [table] parameter specifies the table to insert into.
  /// The [values] parameter is a map of column names to values.
  /// Returns the id of the newly inserted row.
  Future<int> insert({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    return database.insert(table, values);
  }

  /// Updates rows in the database.
  /// The [table] parameter specifies the table to update.
  /// The [values] parameter is a map of column names to values.
  /// The [whereClause] and [whereArgs] parameters are used to filter the rows to update.
  /// Returns the number of rows updated.
  Future<int> update({
    required String table,
    required Map<String, dynamic> values,
    required String whereClause,
    required List<Object?> whereArgs,
  }) async {
    return database.update(table, values, where: whereClause, whereArgs: whereArgs);
  }

  /// Deletes rows from the database.
  /// The [table] parameter specifies the table to delete from.
  /// The [whereClause] and [whereArgs] parameters are used to filter the rows to delete.
  /// Returns the number of rows deleted.
  /// If no rows are deleted, 0 is returned.
  Future<int> delete({
    required String table,
    required String whereClause,
    required List<Object?> whereArgs,
  }) async {
    return database.delete(table, where: whereClause, whereArgs: whereArgs);
  }

  /// Closes the database.
  /// This should be called when the database is no longer needed.
  /// After calling this method, the database should not be used.
  /// If the database is used after calling this method, an exception will be thrown.
  Future<void> close() async {
    await database.close();
  }
}
