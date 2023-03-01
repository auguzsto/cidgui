import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FolderRepository {
  final databaseFactory = databaseFactoryFfi;

  //Add folder.
  Future<void> add(String name, String path) async {
    try {
      //Open database.
      Database db = await databaseFactory.openDatabase(
        'cid.db',
        options: OpenDatabaseOptions(
          version: 1,
          singleInstance: true,
        ),
      );

      await db.insert('folder', {
        'name': name,
        'path': path,
      });
    } catch (e) {
      print(e);
    }
  }

  //Delete by name folder.
  Future<void> deleteByName(String name) async {
    //Open database.
    Database db = await databaseFactory.openDatabase(
      'cid.db',
      options: OpenDatabaseOptions(
        version: 1,
        singleInstance: true,
      ),
    );

    await db.delete(
      'folder',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  //List all folders.
  Future<List<Map<String, dynamic>>> all() async {
    //Open database.
    Database db = await databaseFactory.openDatabase(
      'cid.db',
      options: OpenDatabaseOptions(
        version: 1,
        singleInstance: true,
      ),
    );

    return await db.query('folder', columns: [
      'name',
      'path',
    ]);
  }
}
