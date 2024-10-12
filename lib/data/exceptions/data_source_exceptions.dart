class DataSourceExceptions implements Exception {
  const DataSourceExceptions();
}

class InMemoryDataNotFoundException extends DataSourceExceptions {
  const InMemoryDataNotFoundException();
}
