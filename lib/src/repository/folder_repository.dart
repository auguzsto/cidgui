import 'package:cidgui/src/constants/database_columns.dart';
import 'package:cidgui/src/constants/database_tables.dart';
import 'package:cidgui/src/services/database_services.dart';

class FolderRepository {
  //Add folder.
  Future<void> add(String name, String path) async {
    final db = await DatabaseServices().open();

    await db.insert(DatabaseTables.folder, {
      DatabaseColumnsFolder.name: name,
      DatabaseColumnsFolder.path: path,
    });
  }

  //Delete by name folder.
  Future<void> deleteByName(String name) async {
    final db = await DatabaseServices().open();

    await db.delete(
      DatabaseTables.folder,
      where: '${DatabaseColumnsFolder.name} = ?',
      whereArgs: [name],
    );
  }

  //List all folders.
  Future<List<Map<String, dynamic>>> all() async {
    final db = await DatabaseServices().open();

    return await db.query(DatabaseTables.folder, columns: [
      DatabaseColumnsFolder.name,
      DatabaseColumnsFolder.path,
    ]);
  }

  Future<List<Map<String, dynamic>>> getByName(String name) async {
    final db = await DatabaseServices().open();

    return db.rawQuery(
        "SELECT * FROM ${DatabaseTables.folder} WHERE name LIKE '%$name%'");
  }
}
