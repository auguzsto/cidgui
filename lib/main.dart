import 'package:cidgui/src/themes/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  sqfliteFfiInit();

  final databaseFactory = databaseFactoryFfi;
  Database db = await databaseFactory.openDatabase('cid.db',
      options: OpenDatabaseOptions(
        version: 1,
        singleInstance: true,
      ));
  await db.execute(
    'CREATE TABLE IF NOT EXISTS folder (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, path TEXT)',
  );

  runApp(
    const AppWidget(),
  );
}
