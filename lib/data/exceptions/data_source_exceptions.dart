class DataSourceExceptions implements Exception {
  const DataSourceExceptions();
}

class InMemoryDataNotFoundException extends DataSourceExceptions {
  const InMemoryDataNotFoundException();
}

class LocalDataNotFoundAfterInsertException extends DataSourceExceptions {
  const LocalDataNotFoundAfterInsertException({
    required this.id,
    required this.table,
    required this.data,
  });
  final int id;
  final String table;
  final Object data;
}
