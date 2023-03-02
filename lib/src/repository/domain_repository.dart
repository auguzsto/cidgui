import 'package:cidgui/src/constants/database_columns.dart';
import 'package:cidgui/src/constants/database_tables.dart';
import 'package:cidgui/src/services/database_services.dart';

class DomainRepository {
  //Add domain
  Future<void> add(String name) async {
    final db = await DatabaseServices().open();

    await db.insert(DatabaseTables.domain, {
      DatabaseColumnsDomain.name: name,
    });
  }

  //Remove domain
  Future<void> deleteByName(String name) async {
    final db = await DatabaseServices().open();

    await db.delete(
      DatabaseTables.domain,
      where: "${DatabaseColumnsDomain.name} = ?",
      whereArgs: [name],
    );
  }

  Future<List<Map<String, dynamic>>> all() async {
    final db = await DatabaseServices().open();

    return db.rawQuery("SELECT * FROM ${DatabaseTables.domain}");
  }
}
