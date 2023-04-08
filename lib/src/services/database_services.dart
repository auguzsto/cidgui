import 'package:cidgui/src/constants/database_config.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseServices {
  final databaseFactory = databaseFactoryFfi;

  Future<Database> open() async {
    sqfliteFfiInit();

    final databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      DatabaseConfig.database,
      options: OpenDatabaseOptions(
        version: 3,
        singleInstance: true,
      ),
    );
  }

  Future<void> create(Database db) async {
    await open()
        .then((value) async => await db.execute(DatabaseConfig.createDatabase));
  }
}
