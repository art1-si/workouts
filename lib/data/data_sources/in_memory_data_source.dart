abstract base class InMemoryDataSource<DataT> {
  DataT? _cachedData;
  DateTime? _lastCachedTime;

  DataT? get cachedData => _cachedData;

  DateTime? get lastCachedTime => _lastCachedTime;

  void cacheData(DataT data) {
    _lastCachedTime = DateTime.now();
    _cachedData = data;
  }
}
