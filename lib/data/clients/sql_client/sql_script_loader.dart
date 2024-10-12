import 'dart:io';

class SqlScriptLoader {
  static String load(String filename) {
    final fullPath = '${Directory.current.path}/lib/data/clients/sql_client/sql_scripts/$filename';
    return File(fullPath).readAsStringSync();
  }
}
