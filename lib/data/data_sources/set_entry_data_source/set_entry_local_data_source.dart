import 'package:workouts/data/dto_models/set_entry_dto.dart';
import 'package:workouts/data/exceptions/data_source_exceptions.dart';
import 'package:workouts/data/data_sources/local_data_source.dart';
import 'package:workouts/data/data_sources/set_entry_data_source/set_entry_data_source.dart';

final class SetEntryLocalDataSource extends LocalDataSource implements SetEntryDataSource {
  SetEntryLocalDataSource({required super.sqlDatabaseClient});

  static const _table = 'set_entry';

  @override
  Future<SetEntryDto> addSetEntry({required int exerciseId, required int reps, required double weight}) async {
    final data = {
      'exercise_id': exerciseId,
      'reps': reps,
      'weight': weight,
      'created_at': DateTime.now().toIso8601String(),
    };
    final result = await sqlDatabaseClient.insert(table: _table, values: data);
    final created = await sqlDatabaseClient
        .querySingle(table: _table, parser: SetEntryDto.fromMap, whereClause: 'id = ?', whereArgs: [result]);

    if (created == null) {
      throw LocalDataNotFoundAfterInsertException(
        id: result,
        table: _table,
        data: data,
      );
    }

    return created;
  }

  @override
  Future<void> deleteSetEntry({required int id}) {
    return sqlDatabaseClient.delete(table: _table, whereClause: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<SetEntryDto>> getSetEntries({int? exerciseId, DateTime? startDate, DateTime? endDate}) async {
    final whereClause = StringBuffer();
    final whereArgs = <dynamic>[];

    if (exerciseId != null) {
      whereClause.write('exercise_id = ?');
      whereArgs.add(exerciseId);
    }

    if (startDate != null) {
      if (whereClause.isNotEmpty) {
        whereClause.write(' AND ');
      }
      whereClause.write('created_at >= ?');
      whereArgs.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      if (whereClause.isNotEmpty) {
        whereClause.write(' AND ');
      }
      whereClause.write('created_at <= ?');
      whereArgs.add(endDate.toIso8601String());
    }

    final setEntries = await sqlDatabaseClient.query(
      table: _table,
      parser: SetEntryDto.fromMap,
      whereClause: whereClause.toString(),
      whereArgs: whereArgs,
    );

    return setEntries;
  }

  @override
  Future<SetEntryDto> updateSetEntry({required int id, int? reps, double? weight}) async {
    final data = <String, dynamic>{};
    if (reps != null) {
      data['reps'] = reps;
    }
    if (weight != null) {
      data['weight'] = weight;
    }
    data['updated_at'] = DateTime.now().toIso8601String();

    await sqlDatabaseClient.update(table: _table, values: data, whereClause: 'id = ?', whereArgs: [id]);

    final updated = await sqlDatabaseClient
        .querySingle(table: _table, parser: SetEntryDto.fromMap, whereClause: 'id = ?', whereArgs: [id]);

    return updated!;
  }
}
