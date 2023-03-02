abstract class DatabaseConfig {
  static const String database = "cid.db";
  static const String createDatabase =
      "CREATE TABLE IF NOT EXISTS folder (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE, path TEXT NOT NULL UNIQUE); CREATE TABLE IF NOT EXISTS domain (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);";
}
