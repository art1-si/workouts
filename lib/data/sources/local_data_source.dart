import 'package:workouts/data/clients/sql_client/sql_database_client.dart';

abstract base class LocalDataSource {
  const LocalDataSource({
    required this.sqlDatabaseClient,
  });

  final SqlDatabaseClient sqlDatabaseClient;
}
