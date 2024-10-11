mixin UUIDGenerator {
  String get dateBaseUUID {
    return DateTime.now().toIso8601String();
  }
}
